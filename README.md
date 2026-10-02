# JUNQ FIGHT (Street Tráfego)

Projeto independente de jogo de luta local 1 contra 1, com identidade própria inspirada no gênero dos fighters 2D. O objetivo é criar uma build simples para Windows para jogar entre amigos; jogo online e conteúdo adicional ficam para depois do MVP.

> **Estado atual:** protótipo jogável em Godot 4.7.2, arena lateral 2D, dois personagens placeholder e cenário urbano pixel art. Os placeholders não são os personagens finais. A documentação descreve o estado conhecido do projeto, não promete recursos ainda não implementados.

## Começar

1. Instale/abra o editor Godot 4.7.2 ou compatível com o projeto.
2. Importe a pasta `JUNQ_FIGHT/` pelo arquivo `project.godot`.
3. Execute a cena principal `JUNQ_FIGHT/scenes/graybox.tscn` (ou pressione F6/F5 no editor).

O executável de teste citado no README do protótipo é local e pode não estar incluído neste repositório. Exporte uma build pelo Godot para gerá-la.

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

- [JUNQ_FIGHT/README.md](JUNQ_FIGHT/README.md) — instruções e detalhes do protótipo Godot.
- [docs/STATUS_E_ROADMAP.md](docs/STATUS_E_ROADMAP.md) — estágio atual, pendências e próximos gates.
- [docs/ARQUITETURA.md](docs/ARQUITETURA.md) — composição técnica e fluxo da luta.
- [docs/ARTE_ASSETS_E_LICENCAS.md](docs/ARTE_ASSETS_E_LICENCAS.md) — assets presentes, procedência e regras de uso.
- [docs/ANIMACAO_2D.md](docs/ANIMACAO_2D.md) — pipeline e recomendações para sprites, quadros e cenários.
- [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md) — contexto e histórico de planejamento mantidos no workspace de desenvolvimento.

## Limites e transparência

Este projeto não é afiliado à Capcom nem reutiliza código, personagens, sprites, nomes de golpes ou cenários extraídos de Street Fighter. A referência é ao gênero e às convenções gerais de jogos de luta; arte, personagens e identidade final devem ser originais ou ter licença adequada. Consulte a documentação de assets antes de adicionar conteúdo.

Ainda não há modo online, seleção de personagens, remapeamento de controles, CPU, tutorial, rollback ou pacote final dos lutadores. A execução visual e os testes automatizados precisam ser repetidos no ambiente-alvo antes de declarar uma versão pronta.
