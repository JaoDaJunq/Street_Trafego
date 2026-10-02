extends Node2D

const VIEW_SIZE := Vector2(1280.0, 720.0)
const ARENA_MIN_X := 115.0
const ARENA_MAX_X := 1165.0
const FLOOR_Y := 568.0
const WALK_SPEED := 320.0
const CROUCH_WALK_SPEED := 140.0
const JUMP_SPEED := 560.0
const GRAVITY := 1450.0
const GUARD_WALK_SPEED := 110.0
const FIGHTER_BODY_WIDTH := 54.0
const ATTACK_WINDUP := 0.12
const ATTACK_ACTIVE := 0.10
const ATTACK_RECOVERY := 0.24
const ATTACK_DURATION := ATTACK_WINDUP + ATTACK_ACTIVE + ATTACK_RECOVERY
const ATTACK_COOLDOWN := 0.64
const ATTACK_RANGE := 102.0
const ATTACK_DAMAGE := 10
const HIT_KNOCKBACK := 245.0
const BLOCK_KNOCKBACK := 88.0
const ROUND_DURATION := 60.0
const ROUND_BREAK_DURATION := 2.0
const CONTROL_HINT := "P1: A / D mover, W pular, S agachar, segurar para trás defende, F socar     •     P2: ← / → mover, ↑ pular, ↓ agachar, segurar para trás defende, Ctrl socar"
const SPRITE_FRAME_SIZE := Vector2i(96, 63)
const SPRITE_SCALE := 2.4
const ASSET_ROOT := "res://assets/characters/2d/street_fight/"

var fighters: Array[CharacterBody2D] = []
var status_label: Label
var p1_health_label: Label
var p2_health_label: Label
var p1_health_bar: ProgressBar
var p2_health_bar: ProgressBar
var timer_label: Label
var score_label: Label
var result_panel: PanelContainer
var result_label: Label
var hit_audio: AudioStreamPlayer
var block_audio: AudioStreamPlayer
var swing_audio: AudioStreamPlayer
var jump_audio: AudioStreamPlayer
var land_audio: AudioStreamPlayer
var active_effects: Array[Node2D] = []
var round_over := false
var match_finished := false
var match_paused := false
var round_number := 1
var p1_round_wins := 0
var p2_round_wins := 0
var round_time_remaining := ROUND_DURATION
var round_result_timer := 0.0
var round_result_message := ""
var round_result_reason := ""
var match_result_reason := ""
var feedback_timer := 0.0


func _ready() -> void:
	_register_controls()
	_build_stage()
	_build_fighters()
	_build_audio()
	_build_hud()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_match"):
		_toggle_pause()
		return
	if match_paused:
		return
	_step_effects(delta)
	if round_over:
		if Input.is_action_just_pressed("match_confirm"):
			if match_finished:
				_reset_match()
			else:
				_start_next_round()
			return
		if not match_finished:
			round_result_timer = maxf(0.0, round_result_timer - delta)
			if round_result_timer <= 0.0:
				_start_next_round()
			else:
				result_label.text = _round_intermission_text()
		return

	for fighter in fighters:
		_step_fighter(fighter, delta)
	_step_combat(delta)
	_resolve_fighter_overlap()
	for fighter in fighters:
		_animate_fighter(fighter, delta)
	_tick_feedback(delta)
	if not round_over:
		round_time_remaining = maxf(0.0, round_time_remaining - delta)
		_update_match_hud()
		if round_time_remaining <= 0.0:
			_finish_round_by_timeout()


func _toggle_pause() -> void:
	match_paused = not match_paused
	_refresh_result_panel()


func _register_controls() -> void:
	_add_action("p1_left", [KEY_A])
	_add_action("p1_right", [KEY_D])
	_add_action("p1_jump", [KEY_W])
	_add_action("p1_crouch", [KEY_S])
	_add_action("p1_attack", [KEY_F])
	_add_action("p2_left", [KEY_LEFT])
	_add_action("p2_right", [KEY_RIGHT])
	_add_action("p2_jump", [KEY_UP])
	_add_action("p2_crouch", [KEY_DOWN])
	_add_action("p2_attack", [KEY_CTRL])
	_add_action("match_confirm", [KEY_ENTER])
	_add_action("pause_match", [KEY_ESCAPE])


func _add_action(action_name: String, key_codes: Array[int]) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	for key_code in key_codes:
		var event := InputEventKey.new()
		event.physical_keycode = key_code
		if not InputMap.action_has_event(action_name, event):
			InputMap.action_add_event(action_name, event)


func _build_audio() -> void:
	hit_audio = _make_audio_player("HitSound", 95.0, 0.16, 0.04, -3.0)
	block_audio = _make_audio_player("BlockSound", 410.0, 0.10, 0.02, -5.0)
	swing_audio = _make_audio_player("SwingSound", 190.0, 0.12, 0.20, -10.0)
	jump_audio = _make_audio_player("JumpSound", 260.0, 0.09, 0.01, -11.0)
	land_audio = _make_audio_player("LandSound", 78.0, 0.10, 0.05, -8.0)


func _make_audio_player(
	player_name: String,
	frequency: float,
	duration: float,
	noise_mix: float,
	volume: float
) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.name = player_name
	player.stream = _make_sfx_stream(frequency, duration, noise_mix)
	player.volume_db = volume
	add_child(player)
	return player


func _make_sfx_stream(frequency: float, duration: float, noise_mix: float) -> AudioStreamWAV:
	const SAMPLE_RATE := 22050
	var sample_count := int(float(SAMPLE_RATE) * duration)
	var samples := PackedByteArray()
	samples.resize(sample_count * 2)
	for sample_index in sample_count:
		var progress := float(sample_index) / float(sample_count)
		var time := float(sample_index) / float(SAMPLE_RATE)
		var pitch := lerpf(frequency * 1.45, frequency * 0.62, progress)
		var tone := sin(TAU * pitch * time) * 0.70 + sin(TAU * pitch * 2.1 * time) * 0.20
		var noise := sin(float(sample_index) * 12.9898) * noise_mix
		var envelope := pow(1.0 - progress, 2.2)
		var amplitude := clampf((tone + noise) * envelope * 0.65, -1.0, 1.0)
		samples.encode_s16(sample_index * 2, roundi(amplitude * 32767.0))
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = SAMPLE_RATE
	stream.stereo = false
	stream.data = samples
	return stream


func _play_sfx(player: AudioStreamPlayer) -> void:
	if player == null:
		return
	if player.playing:
		player.stop()
	player.play()


func _build_stage() -> void:
	_add_stage_rect("NightSky", Rect2(Vector2.ZERO, VIEW_SIZE), Color("101421"), -20)
	_add_stage_rect("DistantGlow", Rect2(0.0, 150.0, 1280.0, 290.0), Color("28243e"), -19)
	var city_texture: Texture2D = load("res://assets/stages/2d/urban/back.png")
	for tile_index in 4:
		_add_stage_sprite(city_texture, Vector2(float(tile_index) * 384.0, 42.0), Vector2(4.0, 4.0), -18)
	_add_stage_rect("AlleyWall", Rect2(0.0, 370.0, 1280.0, 130.0), Color("292735"), -15)
	_add_stage_rect("GraffitiBand", Rect2(0.0, 395.0, 1280.0, 8.0), Color("c32a79"), -14)
	_add_stage_rect("Street", Rect2(0.0, 500.0, 1280.0, 220.0), Color("252c39"), -12)
	_add_stage_rect("Sidewalk", Rect2(0.0, 500.0, 1280.0, 42.0), Color("72717d"), -11)
	_add_stage_rect("Curb", Rect2(0.0, 538.0, 1280.0, 8.0), Color("f3a640"), -10)
	_add_stage_rect("RoadMarking", Rect2(0.0, 660.0, 1280.0, 3.0), Color("697383"), -9)
	var fore_texture: Texture2D = load("res://assets/stages/2d/urban/fore.png")
	for tile_index in 3:
		_add_stage_sprite(fore_texture, Vector2(-35.0 + float(tile_index) * 576.0, 160.0), Vector2(3.0, 3.0), -2)
	var car_texture: Texture2D = load("res://assets/stages/2d/urban/car.png")
	_add_stage_sprite(car_texture, Vector2(830.0, 450.0), Vector2(2.8, 2.8), -4)
	_add_stage_rect("FightLane", Rect2(150.0, FLOOR_Y, 980.0, 2.0), Color("ddd0ae"), -1)

	var floor_body := StaticBody2D.new()
	floor_body.name = "ArenaFloor"
	floor_body.collision_layer = 1
	var floor_shape := CollisionShape2D.new()
	var floor_rectangle := RectangleShape2D.new()
	floor_rectangle.size = Vector2(1400.0, 44.0)
	floor_shape.shape = floor_rectangle
	floor_shape.position = Vector2(640.0, FLOOR_Y + 22.0)
	floor_body.add_child(floor_shape)
	add_child(floor_body)


func _add_stage_rect(node_name: String, area: Rect2, color: Color, draw_order: int) -> ColorRect:
	var rectangle := ColorRect.new()
	rectangle.name = node_name
	rectangle.position = area.position
	rectangle.size = area.size
	rectangle.color = color
	rectangle.z_index = draw_order
	add_child(rectangle)
	return rectangle


func _add_stage_sprite(texture: Texture2D, location: Vector2, sprite_scale: Vector2, draw_order: int) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.texture = texture
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.centered = false
	sprite.position = location
	sprite.scale = sprite_scale
	sprite.z_index = draw_order
	add_child(sprite)
	return sprite


func _build_fighters() -> void:
	fighters.append(_make_fighter("JOGADOR 1", true, Vector2(390.0, FLOOR_Y), "p1_left", "p1_right", "p1_jump", "p1_attack", 1.0))
	fighters.append(_make_fighter("JOGADOR 2", false, Vector2(890.0, FLOOR_Y), "p2_left", "p2_right", "p2_jump", "p2_attack", -1.0))


func _make_fighter(
	fighter_name: String,
	use_brawler_girl: bool,
	spawn: Vector2,
	left_action: String,
	right_action: String,
	jump_action: String,
	attack_action: String,
	starting_facing: float
) -> CharacterBody2D:
	var fighter := CharacterBody2D.new()
	fighter.name = fighter_name.replace(" ", "")
	fighter.position = spawn
	fighter.collision_layer = 2
	fighter.collision_mask = 1
	fighter.floor_snap_length = 8.0
	fighter.set_meta("display_name", fighter_name)
	fighter.set_meta("actor_profile", "brawler_girl" if use_brawler_girl else "punk")
	fighter.set_meta("left_action", left_action)
	fighter.set_meta("right_action", right_action)
	fighter.set_meta("jump_action", jump_action)
	fighter.set_meta("crouch_action", "p1_crouch" if fighter_name == "JOGADOR 1" else "p2_crouch")
	fighter.set_meta("attack_action", attack_action)
	fighter.set_meta("attack_animation", "jab" if use_brawler_girl else "punch")
	fighter.set_meta("health", 100)
	fighter.set_meta("facing", starting_facing)
	fighter.set_meta("attack_time", 0.0)
	fighter.set_meta("attack_cooldown", 0.0)
	fighter.set_meta("attack_hit", false)
	fighter.set_meta("stun_time", 0.0)
	fighter.set_meta("is_blocking", false)
	fighter.set_meta("hit_flash_time", 0.0)

	var collision := CollisionShape2D.new()
	var body_shape := RectangleShape2D.new()
	body_shape.size = Vector2(48.0, 136.0)
	collision.shape = body_shape
	collision.position = Vector2(0.0, -68.0)
	fighter.add_child(collision)
	fighter.set_meta("collision_shape", collision)
	fighter.set_meta("body_shape", body_shape)
	fighter.set_meta("is_crouching", false)

	fighter.set_meta("animation_time", 0.0)

	var shadow := Polygon2D.new()
	shadow.name = "GroundShadow"
	var shadow_points := PackedVector2Array()
	for point_index in 16:
		var angle := TAU * float(point_index) / 16.0
		shadow_points.append(Vector2(cos(angle) * 43.0, sin(angle) * 9.0 - 2.0))
	shadow.polygon = shadow_points
	shadow.color = Color(0.03, 0.04, 0.08, 0.6)
	shadow.z_index = -1
	fighter.add_child(shadow)

	var sprite := AnimatedSprite2D.new()
	sprite.name = "FighterSprite"
	sprite.sprite_frames = _build_fighter_frames(use_brawler_girl)
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.scale = Vector2.ONE * SPRITE_SCALE
	sprite.offset = Vector2(0.0, -float(SPRITE_FRAME_SIZE.y) * SPRITE_SCALE * 0.5)
	sprite.flip_h = starting_facing < 0.0
	sprite.play("idle")
	fighter.add_child(sprite)
	fighter.set_meta("sprite", sprite)

	var guard_outline := Line2D.new()
	guard_outline.name = "GuardOutline"
	guard_outline.points = PackedVector2Array([
		Vector2(18.0, -112.0), Vector2(46.0, -96.0), Vector2(53.0, -69.0),
		Vector2(43.0, -43.0), Vector2(30.0, -28.0), Vector2(32.0, -61.0),
		Vector2(39.0, -88.0), Vector2(18.0, -103.0)
	])
	guard_outline.width = 5.0
	guard_outline.default_color = Color("71ddff")
	guard_outline.visible = false
	guard_outline.z_index = 2
	fighter.add_child(guard_outline)
	fighter.set_meta("guard_outline", guard_outline)

	add_child(fighter)
	return fighter


func _build_fighter_frames(use_brawler_girl: bool) -> SpriteFrames:
	var sprite_frames := SpriteFrames.new()
	sprite_frames.remove_animation("default")
	var animation_specs: Dictionary
	if use_brawler_girl:
		animation_specs = {
			"idle": {"frames": 4, "fps": 4.0, "loop": true},
			"walk": {"frames": 10, "fps": 10.0, "loop": true},
			"jump": {"frames": 4, "fps": 10.0, "loop": false},
			"hurt": {"frames": 2, "fps": 9.0, "loop": false},
			"jab": {"frames": 3, "fps": 14.0, "loop": false},
			"punch": {"frames": 3, "fps": 14.0, "loop": false},
			"kick": {"frames": 5, "fps": 12.0, "loop": false},
			"jump_kick": {"frames": 3, "fps": 12.0, "loop": false},
			"dive_kick": {"frames": 5, "fps": 12.0, "loop": false}
		}
	else:
		animation_specs = {
			"idle": {"frames": 4, "fps": 4.0, "loop": true},
			"walk": {"frames": 4, "fps": 9.0, "loop": true},
			"hurt": {"frames": 4, "fps": 10.0, "loop": false},
			"punch": {"frames": 3, "fps": 14.0, "loop": false}
		}

	var profile_path := "brawler_girl/" if use_brawler_girl else "punk/"
	for animation_name in animation_specs:
		var animation_spec: Dictionary = animation_specs[animation_name]
		var sheet: Texture2D = load(ASSET_ROOT + profile_path + animation_name + ".png")
		if sheet == null:
			continue
		sprite_frames.add_animation(animation_name)
		sprite_frames.set_animation_speed(animation_name, animation_spec["fps"])
		sprite_frames.set_animation_loop(animation_name, animation_spec["loop"])
		for frame_index in animation_spec["frames"]:
			var atlas_frame := AtlasTexture.new()
			atlas_frame.atlas = sheet
			atlas_frame.region = Rect2(
				Vector2(float(frame_index) * float(SPRITE_FRAME_SIZE.x), 0.0),
				Vector2(SPRITE_FRAME_SIZE)
			)
			atlas_frame.filter_clip = true
			sprite_frames.add_frame(animation_name, atlas_frame)
	return sprite_frames


func _step_fighter(fighter: CharacterBody2D, delta: float) -> void:
	var left_action: String = fighter.get_meta("left_action")
	var right_action: String = fighter.get_meta("right_action")
	var jump_action: String = fighter.get_meta("jump_action")
	var crouch_action: String = fighter.get_meta("crouch_action")
	var stun_time: float = fighter.get_meta("stun_time")
	var facing: float = fighter.get_meta("facing")
	var back_action: String = left_action if facing > 0.0 else right_action
	var guarding: bool = Input.is_action_pressed(back_action) and stun_time <= 0.0 and fighter.get_meta("attack_time") <= 0.0
	var was_on_floor := fighter.is_on_floor()
	var crouching: bool = was_on_floor and Input.is_action_pressed(crouch_action) and stun_time <= 0.0 and fighter.get_meta("attack_time") <= 0.0 and not guarding and not round_over
	fighter.set_meta("is_crouching", crouching)
	var collision: CollisionShape2D = fighter.get_meta("collision_shape")
	var body_shape: RectangleShape2D = fighter.get_meta("body_shape")
	body_shape.size = Vector2(48.0, 80.0) if crouching else Vector2(48.0, 136.0)
	collision.position.y = -body_shape.size.y * 0.5
	if stun_time > 0.0:
		fighter.set_meta("stun_time", maxf(0.0, stun_time - delta))
		fighter.velocity.x = move_toward(fighter.velocity.x, 0.0, 640.0 * delta)
	elif round_over:
		fighter.velocity.x = move_toward(fighter.velocity.x, 0.0, 760.0 * delta)
	else:
		var direction := Input.get_axis(left_action, right_action)
		var move_speed := GUARD_WALK_SPEED if guarding else CROUCH_WALK_SPEED if crouching else WALK_SPEED
		fighter.velocity.x = direction * move_speed
	if not round_over and fighter.is_on_floor():
		if not guarding and not crouching and Input.is_action_just_pressed(jump_action):
			fighter.velocity.y = -JUMP_SPEED
			_play_sfx(jump_audio)
	else:
		fighter.velocity.y += GRAVITY * delta
	fighter.move_and_slide()
	fighter.position.x = clampf(fighter.position.x, ARENA_MIN_X, ARENA_MAX_X)
	if not was_on_floor and fighter.is_on_floor():
		_play_sfx(land_audio)
	_tick_hit_flash(fighter, delta)


func _resolve_fighter_overlap() -> void:
	if fighters.size() != 2:
		return
	var first := fighters[0]
	var second := fighters[1]
	var first_shape: RectangleShape2D = first.get_meta("body_shape")
	var second_shape: RectangleShape2D = second.get_meta("body_shape")
	var first_top := first.position.y - first_shape.size.y
	var second_top := second.position.y - second_shape.size.y
	var vertical_overlap := first.position.y > second_top and second.position.y > first_top
	if not vertical_overlap:
		return
	var horizontal_distance := absf(second.position.x - first.position.x)
	if horizontal_distance >= FIGHTER_BODY_WIDTH:
		return
	var direction := signf(second.position.x - first.position.x)
	if is_zero_approx(direction):
		direction = -float(first.get_meta("facing"))
	var center := (first.position.x + second.position.x) * 0.5
	first.position.x = clampf(center - direction * FIGHTER_BODY_WIDTH * 0.5, ARENA_MIN_X, ARENA_MAX_X)
	second.position.x = clampf(center + direction * FIGHTER_BODY_WIDTH * 0.5, ARENA_MIN_X, ARENA_MAX_X)


func _animate_fighter(fighter: CharacterBody2D, delta: float) -> void:
	var animation_time: float = fighter.get_meta("animation_time") + delta
	fighter.set_meta("animation_time", animation_time)
	var sprite: AnimatedSprite2D = fighter.get_meta("sprite")
	var is_grounded := fighter.is_on_floor()
	var is_moving := is_grounded and absf(fighter.velocity.x) > 18.0
	var is_attacking: bool = fighter.get_meta("attack_time") > 0.0
	var is_guarding: bool = fighter.get_meta("is_blocking")
	var is_crouching: bool = fighter.get_meta("is_crouching")
	var is_stunned: bool = fighter.get_meta("stun_time") > 0.0
	var animation_name := "idle"
	if is_stunned or fighter.get_meta("hit_flash_time") > 0.0:
		animation_name = "hurt"
	elif is_attacking:
		animation_name = fighter.get_meta("attack_animation")
	elif is_crouching:
		animation_name = "idle"
	elif not is_grounded and sprite.sprite_frames.has_animation("jump"):
		animation_name = "jump"
	elif is_moving:
		animation_name = "walk"
	if not sprite.sprite_frames.has_animation(animation_name):
		animation_name = "idle"
	if sprite.animation != animation_name:
		sprite.play(animation_name)
	sprite.flip_h = float(fighter.get_meta("facing")) < 0.0
	sprite.scale = Vector2(SPRITE_SCALE, SPRITE_SCALE * (0.82 if is_crouching else 1.0))
	sprite.offset.y = -float(SPRITE_FRAME_SIZE.y) * sprite.scale.y * 0.5
	if fighter.get_meta("hit_flash_time") > 0.0:
		sprite.modulate = Color("fff0c2")
	else:
		sprite.modulate = Color("a8eaff") if is_guarding else Color.WHITE
	var guard_outline: Line2D = fighter.get_meta("guard_outline")
	guard_outline.visible = is_guarding
	guard_outline.scale.x = float(fighter.get_meta("facing"))


func _create_impact_effect(location: Vector2, color: Color) -> void:
	var burst := Node2D.new()
	burst.name = "ImpactBurst"
	burst.position = location
	burst.set_meta("effect_lifetime", 0.24)
	burst.set_meta("effect_time_left", 0.24)
	add_child(burst)
	active_effects.append(burst)

	var flash := Polygon2D.new()
	var flash_points := PackedVector2Array()
	for point_index in 12:
		var angle := TAU * float(point_index) / 12.0
		var radius := 20.0 if point_index % 2 == 0 else 9.0
		flash_points.append(Vector2(cos(angle), sin(angle)) * radius)
	flash.polygon = flash_points
	flash.color = color
	burst.add_child(flash)

	for spark_index in 6:
		var angle := TAU * float(spark_index) / 6.0
		var spark := Polygon2D.new()
		spark.polygon = PackedVector2Array([Vector2(-4.0, -2.0), Vector2(4.0, -2.0), Vector2(0.0, 8.0)])
		spark.position = Vector2(cos(angle), sin(angle)) * 13.0
		spark.rotation = angle
		spark.color = color.lightened(0.32)
		spark.set_meta("spark_velocity", Vector2(cos(angle), sin(angle)) * 95.0)
		burst.add_child(spark)


func _step_effects(delta: float) -> void:
	for effect_index in range(active_effects.size() - 1, -1, -1):
		var effect: Node2D = active_effects[effect_index]
		var time_left: float = maxf(0.0, effect.get_meta("effect_time_left") - delta)
		effect.set_meta("effect_time_left", time_left)
		var lifetime: float = effect.get_meta("effect_lifetime")
		var fade := time_left / lifetime
		effect.modulate.a = fade
		for spark in effect.get_children():
			if spark.has_meta("spark_velocity"):
				spark.position += spark.get_meta("spark_velocity") * delta
		if time_left <= 0.0:
			effect.queue_free()
			active_effects.remove_at(effect_index)


func _step_combat(delta: float) -> void:
	if fighters.size() != 2:
		return

	for index in 2:
		var fighter := fighters[index]
		var opponent := fighters[1 - index]
		var horizontal_delta := opponent.position.x - fighter.position.x
		var facing: float = signf(horizontal_delta) if absf(horizontal_delta) > 0.02 else fighter.get_meta("facing")
		fighter.set_meta("facing", facing)
		var cooldown: float = maxf(0.0, fighter.get_meta("attack_cooldown") - delta)
		var previous_attack_time: float = fighter.get_meta("attack_time")
		var attack_time: float = maxf(0.0, previous_attack_time - delta)
		fighter.set_meta("attack_cooldown", cooldown)
		fighter.set_meta("attack_time", attack_time)
		var left_action: String = fighter.get_meta("left_action")
		var right_action: String = fighter.get_meta("right_action")
		var back_action: String = left_action if facing > 0.0 else right_action

		if Input.is_action_just_pressed(fighter.get_meta("attack_action")) and cooldown <= 0.0 and fighter.get_meta("stun_time") <= 0.0 and not fighter.get_meta("is_crouching") and not Input.is_action_pressed(back_action):
			attack_time = ATTACK_DURATION
			fighter.set_meta("attack_time", attack_time)
			fighter.set_meta("attack_cooldown", ATTACK_COOLDOWN)
			fighter.set_meta("attack_hit", false)
			_play_sfx(swing_audio)

		var is_punching: bool = attack_time > 0.0
		var is_blocking: bool = Input.is_action_pressed(back_action) and fighter.get_meta("stun_time") <= 0.0 and not is_punching
		fighter.set_meta("is_blocking", is_blocking)
		var elapsed := ATTACK_DURATION - attack_time if is_punching else 0.0

		if previous_attack_time > 0.0 and attack_time <= 0.0 and not fighter.get_meta("attack_hit"):
			_set_feedback("%s errou o soco!" % fighter.get_meta("display_name"), Color("ffd166"))

		var active_start := ATTACK_WINDUP + ATTACK_ACTIVE
		var is_active := is_punching and elapsed >= ATTACK_WINDUP and elapsed <= active_start
		if is_active and not fighter.get_meta("attack_hit"):
			var distance := (opponent.position.x - fighter.position.x) * facing
			var height_difference := absf(opponent.position.y - fighter.position.y)
			if distance > 0.0 and distance <= ATTACK_RANGE and height_difference <= 112.0:
				fighter.set_meta("attack_hit", true)
				if opponent.get_meta("is_blocking") and opponent.get_meta("facing") == -facing:
					_apply_block(fighter, opponent, facing)
				else:
					_apply_hit(fighter, opponent, facing)
				if round_over:
					return


func _punch_extension(elapsed: float) -> float:
	if elapsed < ATTACK_WINDUP:
		return lerpf(0.0, 0.38, elapsed / ATTACK_WINDUP)
	if elapsed < ATTACK_WINDUP + ATTACK_ACTIVE:
		var active_progress := (elapsed - ATTACK_WINDUP) / ATTACK_ACTIVE
		return lerpf(0.38, 1.0, active_progress)
	var recovery_progress := (elapsed - ATTACK_WINDUP - ATTACK_ACTIVE) / ATTACK_RECOVERY
	return lerpf(1.0, 0.0, recovery_progress)


func _apply_hit(attacker: CharacterBody2D, target: CharacterBody2D, facing: float) -> void:
	var health: int = maxi(0, int(target.get_meta("health")) - ATTACK_DAMAGE)
	target.set_meta("health", health)
	target.set_meta("stun_time", 0.22)
	target.set_meta("hit_flash_time", 0.14)
	target.velocity.x = facing * HIT_KNOCKBACK
	target.velocity.y -= 24.0
	_create_impact_effect(target.position + Vector2(-facing * 20.0, -82.0), Color("ffbd59"))
	_play_sfx(hit_audio)
	_update_health_labels()
	_set_feedback("ACERTO!  %s tira %d de vida" % [attacker.get_meta("display_name"), ATTACK_DAMAGE], Color("ff8b7b"))
	if health == 0:
		_finish_round(fighters.find(attacker), "K.O.")


func _apply_block(attacker: CharacterBody2D, defender: CharacterBody2D, facing: float) -> void:
	defender.velocity.x = facing * BLOCK_KNOCKBACK
	defender.set_meta("stun_time", 0.08)
	attacker.velocity.x = -facing * 65.0
	attacker.set_meta("stun_time", 0.10)
	_create_impact_effect(defender.position + Vector2(-facing * 20.0, -82.0), Color("83d8ff"))
	_play_sfx(block_audio)
	_set_feedback("DEFESA!  %s bloqueou o golpe" % defender.get_meta("display_name"), Color("8ed2ff"))


func _set_feedback(message: String, color: Color) -> void:
	status_label.text = message
	status_label.add_theme_color_override("font_color", color)
	feedback_timer = 1.15


func _tick_feedback(delta: float) -> void:
	if round_over or feedback_timer <= 0.0:
		return
	feedback_timer = maxf(0.0, feedback_timer - delta)
	if feedback_timer == 0.0:
		status_label.text = CONTROL_HINT
		status_label.add_theme_color_override("font_color", Color("d6dbea"))


func _tick_hit_flash(fighter: CharacterBody2D, delta: float) -> void:
	var flash_time: float = maxf(0.0, fighter.get_meta("hit_flash_time") - delta)
	fighter.set_meta("hit_flash_time", flash_time)
	var sprite: AnimatedSprite2D = fighter.get_meta("sprite")
	if flash_time > 0.0:
		sprite.modulate = Color("fff0c2")


func _finish_round_by_timeout() -> void:
	var p1_health := int(fighters[0].get_meta("health"))
	var p2_health := int(fighters[1].get_meta("health"))
	if p1_health > p2_health:
		_finish_round(0, "TEMPO")
	elif p2_health > p1_health:
		_finish_round(1, "TEMPO")
	else:
		_finish_round(-1, "TEMPO")


func _finish_round(winner_index: int, reason: String) -> void:
	if round_over:
		return
	round_over = true
	round_result_timer = ROUND_BREAK_DURATION
	feedback_timer = 0.0
	if winner_index == 0:
		p1_round_wins += 1
	elif winner_index == 1:
		p2_round_wins += 1
	match_finished = p1_round_wins >= 2 or p2_round_wins >= 2
	_update_match_hud()
	if match_finished:
		var champion := "JOGADOR 1" if p1_round_wins >= 2 else "JOGADOR 2"
		match_result_reason = reason
		_show_result("%s VENCEU A PARTIDA!\n%s  •  ENTER para revanche" % [champion, reason])
	else:
		round_result_message = "ROUND EMPATADO" if winner_index < 0 else "JOGADOR %d VENCEU O ROUND" % (winner_index + 1)
		round_result_reason = reason
		_show_result(_round_intermission_text())


func _round_intermission_text() -> String:
	return "%s  •  %s\nPróximo em %d s  •  ENTER para avançar" % [round_result_message, round_result_reason, ceili(round_result_timer)]


func _start_next_round() -> void:
	round_number += 1
	round_over = false
	round_time_remaining = ROUND_DURATION
	round_result_timer = 0.0
	round_result_message = ""
	round_result_reason = ""
	match_result_reason = ""
	_reset_fighters()
	result_panel.visible = false
	status_label.text = CONTROL_HINT
	status_label.add_theme_color_override("font_color", Color("d6dbea"))
	_update_match_hud()


func _reset_match() -> void:
	p1_round_wins = 0
	p2_round_wins = 0
	round_number = 1
	round_over = false
	match_finished = false
	round_time_remaining = ROUND_DURATION
	round_result_timer = 0.0
	round_result_message = ""
	round_result_reason = ""
	match_result_reason = ""
	_reset_fighters()
	result_panel.visible = false
	status_label.text = CONTROL_HINT
	status_label.add_theme_color_override("font_color", Color("d6dbea"))
	_update_match_hud()


func _reset_fighters() -> void:
	for index in fighters.size():
		var fighter := fighters[index]
		fighter.position = Vector2(390.0 if index == 0 else 890.0, FLOOR_Y)
		fighter.velocity = Vector2.ZERO
		var starting_facing := 1.0 if index == 0 else -1.0
		fighter.set_meta("facing", starting_facing)
		fighter.set_meta("health", 100)
		fighter.set_meta("attack_time", 0.0)
		fighter.set_meta("attack_cooldown", 0.0)
		fighter.set_meta("attack_hit", false)
		fighter.set_meta("stun_time", 0.0)
		fighter.set_meta("is_blocking", false)
		fighter.set_meta("is_crouching", false)
		var collision: CollisionShape2D = fighter.get_meta("collision_shape")
		var body_shape: RectangleShape2D = fighter.get_meta("body_shape")
		body_shape.size = Vector2(48.0, 136.0)
		collision.position.y = -68.0
		fighter.set_meta("hit_flash_time", 0.0)
		var sprite: AnimatedSprite2D = fighter.get_meta("sprite")
		sprite.play("idle")
		sprite.scale = Vector2.ONE * SPRITE_SCALE
		sprite.offset.y = -float(SPRITE_FRAME_SIZE.y) * SPRITE_SCALE * 0.5
		sprite.flip_h = starting_facing < 0.0
		var guard_outline: Line2D = fighter.get_meta("guard_outline")
		guard_outline.visible = false
	_update_health_labels()


func _update_match_hud() -> void:
	var total_seconds := maxi(0, ceili(round_time_remaining))
	var minutes := floori(float(total_seconds) / 60.0)
	timer_label.text = "%02d:%02d" % [minutes, total_seconds % 60]
	timer_label.add_theme_color_override("font_color", Color("ffe08a") if total_seconds <= 10 else Color("ffffff"))
	score_label.text = "MELHOR DE 3  •  ROUND %d  •  %d - %d" % [round_number, p1_round_wins, p2_round_wins]


func _show_result(message: String) -> void:
	result_label.text = message
	result_panel.visible = true
	status_label.text = ""


func _refresh_result_panel() -> void:
	if match_paused:
		_show_result("PAUSADO\nESC para continuar")
	elif match_finished:
		var champion := "JOGADOR 1" if p1_round_wins >= 2 else "JOGADOR 2"
		_show_result("%s VENCEU A PARTIDA!\n%s  •  ENTER para revanche" % [champion, match_result_reason])
	elif round_over:
		_show_result(_round_intermission_text())
	else:
		result_panel.visible = false
		status_label.text = CONTROL_HINT
		status_label.add_theme_color_override("font_color", Color("d6dbea"))


func _update_health_labels() -> void:
	if fighters.size() == 2:
		p1_health_label.text = "JOGADOR 1   %d%%" % int(fighters[0].get_meta("health"))
		p2_health_label.text = "JOGADOR 2   %d%%" % int(fighters[1].get_meta("health"))
		p1_health_bar.value = int(fighters[0].get_meta("health"))
		p2_health_bar.value = int(fighters[1].get_meta("health"))
		p1_health_bar.add_theme_stylebox_override("fill", _health_fill_style(p1_health_bar.value))
		p2_health_bar.add_theme_stylebox_override("fill", _health_fill_style(p2_health_bar.value))


func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var title := _make_label("JUNQ FIGHT  |  NOITE NA CIDADE", 24, Color("ffffff"), Vector2(0.0, 22.0), Vector2(1280.0, 38.0), HORIZONTAL_ALIGNMENT_CENTER)
	layer.add_child(title)

	p1_health_label = _make_label("JOGADOR 1   100%", 19, Color("8ed2ff"), Vector2(46.0, 78.0), Vector2(380.0, 30.0))
	layer.add_child(p1_health_label)
	p2_health_label = _make_label("JOGADOR 2   100%", 19, Color("ffab9d"), Vector2(854.0, 78.0), Vector2(380.0, 30.0), HORIZONTAL_ALIGNMENT_RIGHT)
	layer.add_child(p2_health_label)
	p1_health_bar = _make_health_bar(Vector2(46.0, 108.0), ProgressBar.FILL_BEGIN_TO_END)
	layer.add_child(p1_health_bar)
	p2_health_bar = _make_health_bar(Vector2(874.0, 108.0), ProgressBar.FILL_END_TO_BEGIN)
	layer.add_child(p2_health_bar)
	timer_label = _make_label("01:00", 25, Color("ffffff"), Vector2(540.0, 72.0), Vector2(200.0, 36.0), HORIZONTAL_ALIGNMENT_CENTER)
	layer.add_child(timer_label)
	score_label = _make_label("MELHOR DE 3  •  ROUND 1  •  0 - 0", 13, Color("d6dbea"), Vector2(440.0, 108.0), Vector2(400.0, 22.0), HORIZONTAL_ALIGNMENT_CENTER)
	layer.add_child(score_label)

	status_label = _make_label(CONTROL_HINT, 16, Color("d6dbea"), Vector2(40.0, 650.0), Vector2(1200.0, 30.0), HORIZONTAL_ALIGNMENT_CENTER)
	layer.add_child(status_label)
	result_panel = PanelContainer.new()
	result_panel.position = Vector2(240.0, 272.0)
	result_panel.size = Vector2(800.0, 150.0)
	result_panel.custom_minimum_size = Vector2(800.0, 150.0)
	result_panel.visible = false
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.04, 0.06, 0.10, 0.94)
	panel_style.border_color = Color("8ea4c8")
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(12)
	result_panel.add_theme_stylebox_override("panel", panel_style)
	result_label = Label.new()
	result_label.custom_minimum_size = Vector2(800.0, 150.0)
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	result_label.add_theme_font_size_override("font_size", 28)
	result_label.add_theme_color_override("font_color", Color("ffffff"))
	result_panel.add_child(result_label)
	layer.add_child(result_panel)
	_update_health_labels()
	_update_match_hud()


func _make_health_bar(location: Vector2, direction: int) -> ProgressBar:
	var bar := ProgressBar.new()
	bar.position = location
	bar.size = Vector2(360.0, 18.0)
	bar.min_value = 0.0
	bar.max_value = 100.0
	bar.value = 100.0
	bar.show_percentage = false
	bar.fill_mode = direction
	var background := StyleBoxFlat.new()
	background.bg_color = Color("30394b")
	background.corner_radius_top_left = 4
	background.corner_radius_top_right = 4
	background.corner_radius_bottom_left = 4
	background.corner_radius_bottom_right = 4
	bar.add_theme_stylebox_override("background", background)
	bar.add_theme_stylebox_override("fill", _health_fill_style(100.0))
	return bar


func _health_fill_style(health: float) -> StyleBoxFlat:
	var fill := StyleBoxFlat.new()
	var health_ratio := clampf(health / 100.0, 0.0, 1.0)
	fill.bg_color = Color("ed6a5a").lerp(Color("61d095"), health_ratio)
	fill.corner_radius_top_left = 4
	fill.corner_radius_top_right = 4
	fill.corner_radius_bottom_left = 4
	fill.corner_radius_bottom_right = 4
	return fill


func _make_label(
	text_value: String,
	font_size: int,
	font_color: Color,
	location: Vector2,
	box_size: Vector2,
	alignment: int = HORIZONTAL_ALIGNMENT_LEFT
) -> Label:
	var label := Label.new()
	label.text = text_value
	label.position = location
	label.size = box_size
	label.horizontal_alignment = alignment
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	return label
