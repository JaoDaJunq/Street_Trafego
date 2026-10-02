# Arquitetura do protótipo

O código e os assets listados abaixo fazem parte do projeto versionado. Builds locais, caches Godot e referências pessoais de arte não são versionados.

## Tecnologias

- **Engine:** Godot 4.7.2; projeto sinaliza feature `4.7`.
- **Linguagem:** GDScript.
- **Renderização:** Compatibility; o alvo inicial é Windows e o protótipo usa recursos 2D leves.
- **Resolução lógica:** 1280×720; stretch `canvas_items`.
- **Cena atual:** `JUNQ_FIGHT/scenes/graybox.tscn`.
- **Lógica principal:** `JUNQ_FIGHT/scripts/graybox.gd`.

## Organização atual

```text
JUNQ_FIGHT/
├── project.godot
├── scenes/graybox.tscn
├── scripts/graybox.gd
├── tests/test_match_flow.gd
└── assets/
    ├── characters/2d/street_fight/   # cópias runtime dos placeholders
    ├── stages/2d/urban/              # cenário runtime e licença
    ├── 2d_sources/                   # referências e arquivos-fonte ignorados pela Godot
    └── animations/sources/            # FBX antigos, preservados e fora do runtime 2D
```

O protótipo atual concentra montagem da arena, jogadores, HUD, áudio procedural, input, animação, combate e rounds no script `graybox.gd`. É uma estrutura de graybox para iterar rapidamente, não a arquitetura final. Ao iniciar conteúdo original, separar responsabilidades em cenas/scripts menores (lutador, máquina de estados/animação, combate/hitboxes, round manager, HUD e palco) reduzirá acoplamento e facilitará testes.

## Ciclo de atualização

1. `_ready()` registra controles e monta arena, lutadores, áudio e HUD.
2. `_physics_process()` executa atualização durante a luta: passo de cada lutador, combate, resolução de sobreposição, apresentação/animação, relógio e HUD.
3. A luta encerra round por nocaute ou tempo; `Enter` avança/reinicia e `Esc` pausa.
4. Cada jogador é um `CharacterBody2D`, com um sprite animado e colisão; os atlas frames usam células 96×63 px no placeholder atual.

## Regras importantes

- P1 usa A/D/W/S/F; P2 usa setas e Ctrl. Os eventos são registrados pelo script; não estão expostos ainda como opções remapeáveis.
- Bloqueio é relativo ao lado do oponente: pressionar para trás bloqueia ataques frontais. A lógica precisa ser preservada ao separar os componentes.
- A colisão impede os personagens de se atravessarem caminhando no mesmo plano. Cruzar por cima/baixo durante salto/separação vertical é intencional.
- Posição lógica dos pés, sombra e ordenação visual devem ser controladas separadamente da altura visual do sprite. Agachar não deve mover o pivô de chão.
- Animação visual não é frame data. A simulação de combate usa tempo/ticks; startup, janela ativa e recuperação devem continuar explicitamente modelados.

## Próxima evolução estrutural

Antes de adicionar combos e muitos movimentos: extrair estados de personagem e dados de golpe, criar hitboxes hurtboxes reproduzíveis, aplicar testes determinísticos de transição e expor frame data para inspeção. Em seguida adicionar mapeamento configurável de teclado/gamepad e somente então planejar sincronização de rede.
