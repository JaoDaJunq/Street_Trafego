extends SceneTree

const GAME_SCENE := preload("res://scenes/graybox.tscn")
const TEST_FLOOR_Y := 568.0
const TEST_BODY_SEPARATION := 54.0


func _initialize() -> void:
	call_deferred("_run_tests")


func _run_tests() -> void:
	var game: Variant = GAME_SCENE.instantiate()
	root.add_child(game)
	await process_frame

	assert(game.round_time_remaining == 60.0, "A partida deve começar com 60 segundos.")
	assert(game.timer_label.text == "01:00", "O cronômetro inicial deve aparecer em mm:ss.")
	assert(game.p1_round_wins == 0 and game.p2_round_wins == 0, "O placar deve começar zerado.")

	var first: CharacterBody2D = game.fighters[0]
	var second: CharacterBody2D = game.fighters[1]
	assert(first.get_meta("sprite").sprite_frames.has_animation("jab"), "O personagem 1 deve carregar seus sprites de luta.")
	assert(second.get_meta("sprite").sprite_frames.has_animation("punch"), "O personagem 2 deve carregar o conjunto de animações do rival.")
	first.position = Vector2(500.0, TEST_FLOOR_Y)
	second.position = Vector2(520.0, TEST_FLOOR_Y)
	game._resolve_fighter_overlap()
	assert(absf(second.position.x - first.position.x) >= TEST_BODY_SEPARATION, "Lutadores no chão não podem atravessar um ao outro.")

	var first_shape: RectangleShape2D = first.get_meta("body_shape")
	first_shape.size = Vector2(48.0, 80.0)
	first.position = Vector2(520.0, TEST_FLOOR_Y)
	second.position = Vector2(500.0, TEST_FLOOR_Y - 180.0)
	game._resolve_fighter_overlap()
	assert(first.position.x > second.position.x, "Agachar e passar sob um adversário no alto deve permitir trocar de lado.")
	first_shape.size = Vector2(48.0, 136.0)

	game._finish_round(0, "K.O.")
	assert(game.p1_round_wins == 1 and game.round_over, "Uma vitória deve pontuar e encerrar o round.")
	assert(game.result_panel.visible, "O resultado do round deve aparecer.")
	game._start_next_round()
	assert(game.round_number == 2 and game.round_time_remaining == 60.0, "O próximo round deve reiniciar o cronômetro.")
	assert(game.fighters[0].get_meta("health") == 100, "A vida deve reiniciar entre rounds.")

	game.fighters[0].set_meta("health", 40)
	game.fighters[1].set_meta("health", 70)
	game.round_time_remaining = 0.0
	game._finish_round_by_timeout()
	assert(game.p2_round_wins == 1, "No tempo esgotado, a maior vida deve vencer o round.")
	game._start_next_round()

	game._finish_round(0, "K.O.")
	assert(game.match_finished and game.p1_round_wins == 2, "Dois rounds ganhos devem encerrar a melhor de três.")
	game._reset_match()
	assert(not game.match_finished and game.round_number == 1, "A revanche deve iniciar uma nova partida.")
	assert(game.p1_round_wins == 0 and game.p2_round_wins == 0, "A revanche deve zerar o placar.")

	var time_before_pause: float = game.round_time_remaining
	game._toggle_pause()
	game._physics_process(5.0)
	assert(game.round_time_remaining == time_before_pause, "O cronômetro deve congelar durante a pausa.")
	assert(game.result_panel.visible, "A pausa deve mostrar seu painel.")
	game._toggle_pause()
	assert(not game.result_panel.visible, "Retomar deve ocultar o painel de pausa.")

	print("Push 5: colisão de lutadores e fluxo de rounds, timeout, revanche e pausa OK.")
	quit(0)
