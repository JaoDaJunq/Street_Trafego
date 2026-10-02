# JUNQ FIGHT — protótipo de luta 2D

Protótipo local de luta 1 contra 1 feito em Godot **4.7.2 stable**, agora convertido integralmente para uma arena lateral 2D. A cena usa `CharacterBody2D`, sprites animados em pixel art, colisão, cenário urbano em camadas e HUD 2D. A lógica central de rounds, dano, defesa e pausa foi preservada.

## Executar

- Projeto Godot: abra esta pasta pelo arquivo `project.godot`.
- Cena principal: `scenes/graybox.tscn`.
- Build de teste: exporte pelo Godot para a pasta `build/` (ignorada pelo Git; executáveis não são versionados).
- Editor portátil: `%LOCALAPPDATA%\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe`.

## Controles

- Jogador 1: `A` / `D` andar, `W` pular, `S` agachar, `F` socar.
- Jogador 2: `←` / `→` andar, `↑` pular, `↓` agachar, `Ctrl` socar.
- Defesa: segure a direção oposta à que o lutador encara; recua devagar e bloqueia golpes frontais.
- `Esc`: pausar/continuar. `Enter`: avançar entre rounds ou iniciar revanche.

O jogo mantém a melhor de 3, rounds de 60 segundos, dez acertos para K.O., decisão por vida no tempo, empurrão, stun, bloqueio e efeitos sonoros procedurais. Os lutadores colidem no chão; um pode cruzar por cima do outro quando há separação vertical.

## Sprites e animação

- A primeira versão usa personagens genéricos do pacote **Streets of Fight**: Brawler Girl como placeholder do P1 e Enemy Punk como rival do P2. Não são os modelos finais do Jão ou dos amigos.
- O pacote foi criado por **ansimuz** e a página o marca como CC0; a licença incluída também permite uso, modificação e redistribuição. Crédito é opcional, mas fica registrado aqui e em `assets/stages/2d/urban/LICENSE-StreetsOfFight.txt`.
- Spritesheets separados por animação foram copiados para `assets/characters/2d/street_fight/`; cenário/parallax e props urbanos estão em `assets/stages/2d/urban/`.
- Cada folha de personagem usa células horizontais de **96×63 px**. O P1 tem idle (4), caminhada (10), salto (4), dano (2), jab (3), soco (3), chute (5), chute no salto (3) e dive-kick (5). O P2 tem idle (4), caminhada (4), dano (4) e soco (3). A Godot monta `SpriteFrames` por célula e troca estados via `AnimatedSprite2D`.
- Não existe um único leiaute obrigatório para todas as folhas de luta. Nosso padrão de estados é idle, andar, agachar, salto, defesa, ataque e dano; cada golpe possui startup, janela ativa, recuperação e regras de colisão próprias. A simulação está a 60 ticks/s; os tempos atuais equivalem aproximadamente a 7 ticks de preparação, 6 ativos e 14–15 de recuperação. Isso é frame data original do protótipo, não extraído de Street Fighter.
- O P1 usa um personagem feminino genérico por enquanto; será substituído pelo sprite original do Jão quando criarmos sua folha. O P2 é outro placeholder CC0. O estilo de pixels/cor também poderá ser trocado sem alterar o código de luta.

## Fontes públicas pesquisadas

- **Streets of Fight (CC0)** — escolhido para primeiro cenário e placeholders de luta; inclui cidade em camadas, props, personagem e inimigo com movimentos. [OpenGameArt](https://opengameart.org/content/streets-of-fight).
- **Dojo Jim (CC0)** — 25 imagens de um personagem 64×64, com caminhada/punch e combo; baixado e arquivado como alternativa, mas pequeno demais para ser o lutador visível do protótipo. [OpenGameArt](https://opengameart.org/content/dojo-jim).
- **Fighting Character Template Mustermann 2 (CC0)** — muitas cels de poses de luta e versões voltadas para lados diferentes; útil como referência para poses, não escolhido como personagem jogável. [OpenGameArt](https://opengameart.org/content/fighting-character-template-mustermann-2-a001aaaa001-karate).
- **Samurai Fighter Asset Pack (CC0, itch.io)** — anuncia mais de dez animações, seis ataques e cenário; mantido como opção para comparação visual, sem baixar/importar nesta etapa. [itch.io](https://favi-gmdv.itch.io/samurai-fighter-asset-pack).
- Pacotes e ZIPs de referência ficam em `assets/2d_sources/`, separados dos assets efetivamente carregados pelo jogo. Essa pasta e `assets/animations/sources/` ficam fora da varredura de importação com `.gdignore`; os FBX originais foram preservados, mas não participam da build 2D.

## Código e licenças

- O projeto continua na Godot; migramos a apresentação e a física de `Node3D`/`CharacterBody3D` para `Node2D`/`CharacterBody2D`, sem trocar de engine.
- Foram encontrados projetos públicos de luta com código aberto, como [Ikemen GO (MIT)](https://github.com/ikemen-engine/Ikemen-GO), [Sakuga Engine (MIT, Godot 4 .NET/C#)](https://github.com/NoisyChain/Sakuga-Engine) e [Godot fighter demo](https://github.com/ca3games/Godot-fighter-demo). São engines/demos independentes: os assets têm licenças separadas e não foram copiados para cá.
- A varredura não buscou nem integrou código, personagens, cenários ou sprites vazados de Street Fighter. Um projeto estar público no GitHub não significa que a Capcom tenha autorizado a reutilização; usamos código próprio e assets com licença indicada.
- Tripo, Blender, AccuRIG, Mixamo e os FBXs deixam de ser requisitos para o MVP 2D. Nenhum arquivo 3D original foi apagado.

## Validação

- A cena principal e o projeto foram carregados pelo Godot 4.7.2 em modo headless sem erros reportados; o build Windows foi exportado.
- Existe um teste automatizado em `tests/test_match_flow.gd` cobrindo sprites, colisão/passagem vertical, rounds, timeout, pausa e revanche. O runner headless deste ambiente encerrou sem imprimir o resultado do teste; considere a suite pendente até rodá-la no editor/ambiente local.
- A revisão visual ainda deve ser feita em janela aberta para confirmar tamanho/alinhamento dos sprites e composição do cenário.
