# JUNQ FIGHT (Street Tráfego)

Projeto independente de jogo de luta local 1 contra 1, com identidade própria inspirada no gênero dos fighters 2D. O objetivo é criar uma build simples para Windows para jogar entre amigos; modo online e conteúdo adicional ficam para depois do MVP.

> **Estado atual:** o workspace de desenvolvimento contém um protótipo em Godot 4.7.2, arena lateral 2D, dois personagens placeholder e cenário urbano pixel art. Os placeholders não são os personagens finais. Este repositório GitHub recebeu primeiro a documentação; código e assets ainda não foram publicados aqui.

## Executar o protótipo local

Instale/abra Godot 4.7.2 e importe `JUNQ_FIGHT/project.godot` no workspace de desenvolvimento. Esses arquivos ainda não fazem parte deste repositório. Não há executável publicado aqui.

## Controles do protótipo local

| Ação | Jogador 1 | Jogador 2 |
|---|---|---|
| Andar | A / D | ← / → |
| Pular | W | ↑ |
| Agachar | S | ↓ |
| Socar | F | Ctrl |
| Defender | Manter direção para trás em relação ao oponente | Manter direção para trás em relação ao oponente |
| Pausar | Esc | Esc |
| Confirmar / avançar round | Enter | Enter |

## O que o protótipo já contém

- Luta local no mesmo teclado, melhor de três rounds de 60 segundos.
- Movimento lateral, salto, agachamento, orientação para o oponente e colisão no chão.
- Passagem por cima/baixo quando há separação vertical, sem atravessamento caminhando no mesmo plano.
- Soco, dano, defesa frontal, empurrão, stun, efeitos sonoros procedurais, vida, cronômetro, resultado e revanche.
- Personagens e cenário de demonstração pixel art licenciados como CC0.

## Documentação

- [Estado e roadmap](docs/STATUS_E_ROADMAP.md) — estágio atual, pendências e próximos gates.
- [Arquitetura](docs/ARQUITETURA.md) — composição técnica e fluxo da luta local.
- [Arte, assets e licenças](docs/ARTE_ASSETS_E_LICENCAS.md) — inventário do workspace e política de uso.
- [Animação 2D](docs/ANIMACAO_2D.md) — pipeline, quadros, cenários e correções visuais.

## Limites e transparência

O projeto não é afiliado à Capcom nem reutiliza código, personagens, sprites, nomes de golpes ou cenários extraídos de Street Fighter. A inspiração é o gênero e suas convenções gerais; arte, personagens e identidade final devem ser originais ou licenciados.

Ainda não há modo online, seleção de personagens, remapeamento de controles, CPU, tutorial, rollback ou pacote final dos lutadores. A validação visual e os testes automatizados precisam ser repetidos no ambiente-alvo antes de declarar uma versão pronta.