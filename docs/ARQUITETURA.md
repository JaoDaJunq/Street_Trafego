# Arquitetura do protótipo

Este documento descreve a cópia local de desenvolvimento. O GitHub recebeu primeiro a documentação; código e assets ainda não foram publicados neste repositório.

## Tecnologias

- **Engine:** Godot 4.7.2; projeto sinaliza feature `4.7`.
- **Linguagem:** GDScript.
- **Renderização:** Compatibility; alvo inicial Windows e protótipo 2D leve.
- **Resolução lógica:** 1280×720; stretch `canvas_items`.
- **Cena principal:** `JUNQ_FIGHT/scenes/graybox.tscn`.
- **Lógica principal:** `JUNQ_FIGHT/scripts/graybox.gd`.

## Organização atual do workspace

```text
JUNQ_FIGHT/
├── project.godot
├── scenes/graybox.tscn
├── scripts/graybox.gd
├── tests/test_match_flow.gd
└── assets/
    ├── characters/2d/street_fight/   # cópias runtime dos placeholders
    ├── stages/2d/urban/              # cenário runtime e licença
    ├── 2d_sources/                   # referências fora da importação Godot
    └── animations/sources/            # FBX antigos, fora do runtime 2D
```

O protótipo concentra montagem da arena, jogadores, HUD, áudio procedural, input, animação, combate e rounds em `graybox.gd`. É uma estrutura de graybox para iterar rapidamente, não a arquitetura final. Ao iniciar conteúdo original, separar responsabilidades em cenas/scripts menores (lutador, máquina de estados/animação, combate/hitboxes, round manager, HUD e palco) reduz acoplamento e facilita testes.

## Ciclo da partida

1. `_ready()` registra controles e monta arena, lutadores, áudio e HUD.
2. `_physics_process()` atualiza lutadores, combate, sobreposição, apresentação, relógio e HUD.
3. A luta encerra round por nocaute ou tempo; `Enter` avança/reinicia e `Esc` pausa.
4. Cada jogador é um `CharacterBody2D`, com sprite animado e colisão; os atlas frames do placeholder usam células de 96×63 px.

## Regras importantes

- P1 usa A/D/W/S/F; P2 usa setas e Ctrl. O input é registrado pelo script, sem opções de remapeamento ainda.
- Bloqueio é relativo ao oponente: pressionar para trás bloqueia ataques frontais.
- Colisão impede atravessamento caminhando no mesmo plano. Cruzar por cima/baixo durante salto/separação vertical é intencional.
- Posição lógica dos pés, sombra e ordenação visual devem ser controladas separadamente da altura visual do sprite. Agachar não deve mover o pivô do chão.
- Animação visual não é frame data. Startup, janela ativa e recuperação permanecem explicitamente modelados.

## Próxima evolução estrutural

Antes de adicionar combos e muitos movimentos: extrair estados de personagem e dados de golpe, criar hitboxes/hurtboxes reproduzíveis, aplicar testes determinísticos de transição e expor frame data para inspeção. Depois, adicionar mapeamento configurável de teclado/gamepad; sincronização de rede fica para depois do protótipo local.