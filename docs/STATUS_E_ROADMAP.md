# Estado e roadmap

Última revisão deste documento: 2026-10-02. O repositório descreve o protótipo atual; itens futuros não devem ser interpretados como recursos disponíveis.

## Situação atual

**Base:** Godot 4.7.2, GDScript, renderizador Compatibility, viewport 1280×720 com `canvas_items`. A migração visual de 3D para luta lateral 2D foi feita sem trocar de engine.

**Protótipo:** arena urbana, P1 e P2 locais, controles no teclado, movimento, salto/agachamento, bloqueio frontal mantendo para trás, ataques básicos, dano e rounds. As artes atuais são placeholders CC0. Ainda falta substituir os placeholders por lutadores autorais.

**Validação conhecida:** a documentação local relata carregamento headless da cena e export de uma build Windows em desenvolvimento. O runner automatizado não confirmou claramente o resultado dos testes. Portanto, testes de fluxo, revisão visual e execução em instalação limpa permanecem pendentes.

## Pendências prioritárias

1. Corrigir e validar o alinhamento dos pés ao chão: o sprite parece flutuar; a animação de agachar parece afundar. Usar um ponto de ancoragem comum (sola/ground pivot) para todos os cels, sem alterar o chão físico.
2. Separar sombra do corpo que salta, mantendo-a projetada no plano do chão.
3. Fazer revisão de composição e oclusão dos elementos de primeiro plano do cenário, para não esconder nem sobrepor os lutadores de forma confusa.
4. Rodar a cena e os testes de fluxo de rounds no Godot local; registrar claramente comandos e resultado.
5. Definir o esquema final de controles (teclado e/ou gamepads) e adicionar input remapeável antes de ampliar os comandos.
6. Produzir conceito original do primeiro lutador e um pequeno conjunto de estados para testar a pipeline de arte dentro do jogo.

## Sequência sugerida

### A — Estabilizar o protótipo

- Ajustar baseline, pivô, agachamento, sombra, camadas de cenário e leitura visual.
- Validar movimento, defesa, ataques, colisões, rounds, pausa e revanche sem regressões.
- Confirmar execução/export no Windows-alvo e medir memória/desempenho.

### B — Primeiro lutador (vertical slice)

- Aprovar brief, silhueta, paleta, vista lateral, escala e pivô dos pés.
- Criar sprites originais para idle, caminhada, agachamento, salto, defesa, ataques básicos, dano e nocaute.
- Integrar animações à lógica existente e revisar hitboxes, timing, legibilidade e consistência de escala.

### C — Conteúdo mínimo de jogo

- Criar segundo lutador e arena final; polir efeitos, áudio e HUD.
- Concluir seleção/fluxo da partida, opções básicas e sessão de testes com amigos.
- Gerar build privada Windows limpa e verificar instalação em máquina alvo.

### D — Depois do MVP

Treino avançado, CPU, tutorial, mais personagens/arenas e online privado são expansões. Netcode/rollback só deve ser iniciado após a simulação local estar determinística, testada e estável.

## Critério para considerar o MVP pronto

- Dois lutadores visualmente distintos e uma arena final.
- Partida local completa, revanche e controles entendíveis.
- Sem bugs de pés flutuando/afundando, atravessamento lateral indevido ou oclusões ruins.
- Testes de regressão e uma sessão prolongada concluídos; build instalada e aberta em ambiente limpo.
- Direitos/licenças de cada asset e dependência documentados.
