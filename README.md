# JUNQ FIGHT (Street Tráfego)

Projeto independente de jogo de luta local 1 contra 1, com identidade própria inspirada no gênero dos fighters 2D. O objetivo é criar uma build simples para Windows para jogar entre amigos; jogo online e conteúdo adicional ficam para depois do MVP.

> **Estado atual:** protótipo em Godot 4.7.2, arena lateral 2D, dois personagens placeholder e cenário urbano pixel art. Os placeholders não são os personagens finais. Código, assets com licença registrada e documentação estão versionados neste repositório; builds e referências pessoais privadas ficam fora dele.

## Começar

Instale/abra Godot 4.7.2, clone/baixe este repositório e importe `JUNQ_FIGHT/project.godot` no editor. Execute a cena principal `JUNQ_FIGHT/scenes/graybox.tscn` (F6/F5 no editor). Exporte uma build pelo Godot para gerá-la; executáveis não são versionados.

Executáveis e caches importados são ignorados pelo Git; a build pode ser regenerada a partir do projeto Godot e dos assets versionados.

## Controles do protótipo

| Ação | Jogador 1 | Jogador 2 |
|---|---|---|
| Andar | A / D | ← / → |
| Pular | W | ↑ |
| Agachar | S | ↓ |
| Socar | F | Ctrl |
| Defender | Manter direção para trás em relação ao oponente | Manter direção para trás em relação ao oponente |
| Pausar | Esc | Esc |
| Confirmar / avançar round | Enter | Enter |

## O que existe hoje

- Luta local no mesmo teclado, melhor de três rounds de 60 segundos.
- Movimento lateral, salto, agachamento, orientação para o oponente, colisão no chão e passagem por cima/baixo quando há separação vertical.
- Soco, dano, defesa frontal, empurrão, stun, efeitos sonoros procedurais, vida, cronômetro, resultado e revanche.
- Personagens e cenário de demonstração em pixel art licenciados como CC0.

## Mapa do repositório

- [`docs/STATUS_E_ROADMAP.md`](docs/STATUS_E_ROADMAP.md) — estágio atual, pendências e próximos gates.
- [`docs/ARQUITETURA.md`](docs/ARQUITETURA.md) — composição técnica e fluxo da luta.
- [`docs/ARTE_ASSETS_E_LICENCAS.md`](docs/ARTE_ASSETS_E_LICENCAS.md) — assets presentes, procedência e regras de uso.
- [`docs/ANIMACAO_2D.md`](docs/ANIMACAO_2D.md) — pipeline e recomendações para sprites, quadros e cenários.
- [`JUNQ_FIGHT/ANIMACAO_2D_PESQUISA_E_PLANO.md`](JUNQ_FIGHT/ANIMACAO_2D_PESQUISA_E_PLANO.md) — pesquisa completa, diagnóstico dos bugs visuais, referências públicas e plano do próximo personagem.
- [`docs/DECISOES_E_HISTORICO.md`](docs/DECISOES_E_HISTORICO.md) — escolhas de engine/escopo, histórico dos pushes e validações conhecidas.
- [`docs/PERSONAGENS_E_CENARIOS.md`](docs/PERSONAGENS_E_CENARIOS.md) — briefs dos lutadores e conceito da arena.

## Limites e transparência

Este projeto não é afiliado à Capcom nem reutiliza código, personagens, sprites, nomes de golpes ou cenários extraídos de Street Fighter. A referência é ao gênero e às convenções gerais de jogos de luta; arte, personagens e identidade final devem ser originais ou ter licença adequada. Consulte a documentação de assets antes de adicionar conteúdo.

Ainda não há modo online, seleção de personagens, remapeamento de controles, CPU, tutorial, rollback ou pacote final dos lutadores. A execução visual e os testes automatizados precisam ser repetidos no ambiente-alvo antes de declarar uma versão pronta.
