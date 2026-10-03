# Decisões e histórico do projeto

Registro resumido de decisões de escopo e marcos. Os pushes citados abaixo são históricos da evolução do protótipo; não indicam que cada versão antiga esteja disponível neste repositório.

## Decisões principais

- **Jogo para amigos:** prioridade em uma luta local simples no Windows; comercialização não é objetivo do MVP.
- **Godot 4.7.2 + GDScript:** escolhida no lugar da Unreal para reduzir peso de instalação/iteração no computador-alvo e atender melhor ao escopo 2D/local. O renderizador Compatibility mantém a base leve.
- **Migração 3D → 2D lateral:** adotada em 2026-10-01 após dificuldades de produção de modelos/animações 3D. O foco passou para sprites pixel art, poses expressivas e cenários em planos. A engine não mudou.
- **Arte própria para os lutadores finais:** personagens comerciais de Street Fighter não são fonte de código ou assets. Placeholders atuais servem para validar a mecânica e têm licença CC0 documentada.
- **Online depois do MVP:** primeiro validar simulação local, fluxo, controles e estabilidade; só então pesquisar rollback/partidas entre amigos.
- **Push 4 (gamepads/remapeamento) adiado:** teclado continua como entrada atual; confirmar controles pretendidos antes de implementar suporte definitivo.

## Histórico dos pushes

- **Push 1 — primeiro combate:** ataque simples, dano, alcance, empurrão/stun, HUD, K.O. e reinício. O usuário confirmou que o golpe e o empurrão funcionavam.
- **Push 2 — guarda e feedback:** movimento defensivo, fases de preparação/ativo/recuperação, vida, flash e feedback de acerto/bloqueio/erro. Foi pedido bloqueio usando a direção “para trás” relativa ao adversário e suporte a cruzar de lado/orientação.
- **Push 3 — rounds:** melhor de três, timer, decisão por vida/empate, intermissão, pausa e revanche.
- **Push 4 — controles físicos:** intencionalmente pulado naquele momento, permanece pendente.
- **Push 5 — apresentação:** membros procedurais, movimento/poses, reação visual, efeitos e áudio procedural. O usuário pediu visualização e aprovou a etapa em seguida.
- **Migração 2D:** arena, jogadores, HUD, spritesheets e cenário urbano convertidos para 2D. O usuário apontou flutuação no chão e afundamento ao agachar; o diagnóstico e a pesquisa estão em [ANIMACAO_2D.md](ANIMACAO_2D.md).
- **Produção atual do Jão (03/10/2026):** os conceitos são feitos e revisados um movimento por vez. Defesa em pé, chute no ar e chute lateral com a perna da frente foram aprovados visualmente. Ainda faltam revisão das demais folhas, fatiamento, pivôs/tempos e integração na Godot. Recuperação do nocaute e reação não letal foram criadas e aguardam revisão. O chute lateral da perna de trás v06 foi reprovado e não deve ser integrado. O inventário e o processo vinculante estão em [ANIMACAO_2D.md](ANIMACAO_2D.md).

## Validação e limites conhecidos

- Houve confirmações visuais manuais em algumas versões 3D e execução headless/reportada durante a migração. Isso não substitui uma regressão da versão 2D atual.
- Resultado completo dos testes automatizados ainda não foi confirmado; a revisão visual do build final também precisa ser repetida no Windows-alvo.
- As etapas online, CPU, tutorial, seleção/remapeamento e conteúdo final são metas, não funcionalidades prontas.
- O hardware local foi considerado para limitar o escopo e otimizar a build, mas seus identificadores e detalhes de máquina não fazem parte desta documentação pública.
