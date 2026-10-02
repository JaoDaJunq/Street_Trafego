# Estado e roadmap

Última revisão: 2026-10-02. Este documento descreve o protótipo local; itens futuros não são recursos disponíveis.

## Situação atual

**Base:** Godot 4.7.2, GDScript, renderizador Compatibility, viewport 1280×720 com `canvas_items`. A migração visual de 3D para luta lateral 2D foi feita sem trocar de engine.

**Protótipo local:** arena urbana, P1 e P2 locais, controles no teclado, movimento, salto/agachamento, bloqueio frontal mantendo para trás, ataques básicos, dano e rounds. As artes atuais são placeholders CC0. Ainda falta substituir os placeholders por lutadores autorais.

**Validação conhecida:** há relato de carregamento headless da cena e export de uma build Windows durante o desenvolvimento. O runner automatizado não confirmou claramente o resultado dos testes. Testes de fluxo, revisão visual e execução em instalação limpa permanecem pendentes.

## Pendências prioritárias

1. Corrigir e validar o alinhamento dos pés ao chão: o sprite parece flutuar; a animação de agachar parece afundar. Usar ponto de ancoragem comum (sola/ground pivot) em todos os cels sem alterar o chão físico.
2. Separar a sombra do corpo que salta, mantendo-a projetada no plano do chão.
3. Revisar composição e oclusão dos elementos de primeiro plano do cenário para não esconder nem sobrepor lutadores de forma confusa.
4. Rodar cena e testes de fluxo de rounds no Godot; registrar comando e resultado.
5. Definir controles finais (teclado e/ou gamepads) e adicionar remapeamento antes de ampliar os comandos.
6. Produzir conceito original do primeiro lutador e um conjunto pequeno de estados para validar a pipeline de arte no jogo.

## Sequência sugerida

### A — Estabilizar o protótipo

- Ajustar baseline, pivô, agachamento, sombra, camadas do cenário e leitura visual.
- Validar movimento, defesa, ataques, colisões, rounds, pausa e revanche sem regressões.
- Confirmar execução/export no Windows-alvo e medir memória/desempenho.

### B — Primeiro lutador (vertical slice)

- Aprovar brief, silhueta, paleta, vista lateral, escala e pivô dos pés.
- Criar sprites originais para idle, caminhada, agachamento, salto, defesa, ataques básicos, dano e nocaute.
- Integrar animações à lógica existente e revisar hitboxes, timing, legibilidade e escala.

### C — Conteúdo mínimo de jogo

- Criar segundo lutador e arena final; polir efeitos, áudio e HUD.
- Concluir seleção/fluxo da partida, opções básicas e testes com amigos.
- Gerar build privada Windows limpa e verificar instalação em máquina-alvo.

### D — Depois do MVP

Treino avançado, CPU, tutorial, mais personagens/arenas e online privado são expansões. Netcode/rollback deve começar só após a simulação local estar determinística, testada e estável.

## Critério de MVP

- Dois lutadores visualmente distintos e uma arena final.
- Partida local completa, revanche e controles entendíveis.
- Sem bugs de pés flutuando/afundando, atravessamento lateral indevido ou oclusões ruins.
- Regressão e sessão prolongada concluídas; build instalada e aberta em ambiente limpo.
- Direitos/licenças de cada asset e dependência documentados.