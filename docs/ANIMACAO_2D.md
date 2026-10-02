# Pipeline de animação 2D para luta

Este é um guia inicial de produção para os personagens autorais. Não existe uma contagem universal de quadros por golpe nem uma folha oficial única que todos os jogos usem. As quantidades abaixo são **faixas de planejamento** para testar escala/esforço; gameplay, estilo e leitura final definem o resultado.

## Princípios

- Ação legível primeiro: silhueta clara, antecipação suficiente, pose de contato forte e recuperação compreensível.
- Manter pivô de chão e escala consistentes entre cels. Cada quadro deve ser conferido lado a lado em sequência e dentro da arena, não só isolado no editor.
- Separar desenho/frames (arte) de startup, active, recovery, dano, bloqueio e hitstop (lógica do jogo). Rodar mais rápido ou segurar uma cel são decisões de timing, não necessariamente novos desenhos.
- Definir se o sprite olha para um lado e é espelhado no jogo, ou se exige arte separada para os dois lados; conferir assimetria de roupa, cabelo e acessórios antes de espelhar.
- Sombras projetadas e ponto de contato dos pés pertencem ao plano do chão; o sprite pode subir durante salto sem deslocar a sombra.

## Faixas iniciais para protótipo

| Estado | Cels sugeridas para rascunho |
|---|---:|
| Idle/respiração | 5–8 |
| Andar para frente/trás | 6–8 por ciclo |
| Agachar e levantar | 2–3 por transição, mais 1–3 de hold |
| Salto | 2–3 de saída, 3–5 no ar, 2–3 de aterrissagem |
| Entrar em defesa / reação de block | 2–4 cada; hold separado |
| Soco rápido / médio / forte | 4–6 / 6–8 / 7–10 |
| Chute | 6–10 |
| Tomar golpe | 2–5 por reação |
| Queda/nocaute/levantar | 6–12 para uma primeira leitura |

Combos, agarrões, vitória, derrota e movimentos especiais aumentam o conjunto. Reuso/espelhamento pode reduzir arte única, mas nem toda pose deve ser espelhada. Começar por um pacote vertical slice de idle, caminhada, agachar, salto, defesa, um soco, um chute, hit e nocaute antes de desenhar todo o moveset.

## Convenção de folha e metadados

Escolher tamanho de canvas, área segura, pivô, direção, escala e nomenclatura antes de gerar muitas imagens. Usar uma folha por estado ou atlas com metadados explícitos (retângulos/cels e duração). Não pressupor que todas as ações terão o mesmo número ou tamanho de quadros. Documentar velocidade de exibição e eventos de gameplay por movimento.

Uma ficha por golpe deve guardar pelo menos: nome, comando, cels, duração por cel, startup, frames ativos, recovery, dano, hit/block stun, hitstop, alcance, altura (alto/médio/baixo), cancelamentos e reação do oponente. No protótipo atual os tempos básicos são aproximadamente 0,12 s de preparação, 0,10 s ativo e 0,24 s de recuperação a 60 atualizações por segundo; isso é frame data do protótipo, não dado oficial de Street Fighter.

## Cenário por planos

Organizar cenário em fundo distante, plano intermediário, plano de luta/chão e elementos de primeiro plano. Cada plano tem velocidade/parallax e regra de oclusão próprias. O primeiro plano deve emoldurar sem encobrir os lutadores nem confundir a linha dos pés. Manter colisão, limites e linha de chão separados da arte decorativa.

## Correções visuais antes de produzir em escala

- **Flutuação:** pivô/offset do sprite não coincide com o chão lógico; escala e offset podem ser aplicados duas vezes. Alinhar a sola de referência diretamente ao ground pivot.
- **Afundar ao agachar:** alterar escala vertical com offset derivado do tamanho pode deslocar a base. Manter pés ancorados e trocar para uma cel de agachamento desenhada com a mesma linha-base.
- **Sombra no salto:** não deixar sombra como filha que acompanha a altura do corpo; posicioná-la no plano do palco e ajustar apenas a elipse/opacidade com a altura.
- **Oclusão:** ajustar profundidade e Y-sort dos props; não resolver sobreposição visual alterando colisão dos lutadores.

## IA como assistência, não fonte de verdade

Geração de imagem pode acelerar conceito, exploração de paleta ou rascunho por pose, mas consistência de identidade, volume, pivô, proporções e sequência temporal ainda requer direção humana e revisão quadro a quadro. Requisitos do pipeline: arte original ou com direitos claros, referência aprovada, personagem/roupa fixados, poses nomeadas, linha-base comum, transparência limpa, correção de anatomia, teste em loop e registro da ferramenta/termos usados. Não alimentar ou reproduzir sprites comerciais protegidos.

## Leituras técnicas

- [Godot — AnimatedSprite2D](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html) e [SpriteFrames](https://docs.godotengine.org/en/stable/classes/class_spriteframes.html).
- [Godot — CanvasItem e ordenação Z](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html), [Sprite2D](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html) e [parallax 2D](https://docs.godotengine.org/en/stable/tutorials/2d/2d_parallax.html).
- [GDC — Animation Bootcamp: Fluid and Powerful Animation](https://www.gdcvault.com/play/1020017/Animation-Bootcamp-Fluid-and-Powerful) — princípios gerais de animação de luta.
- [SBGames 2019 — ML-assisted asset generation / Trajes Fatais](https://www.sbgames.org/sbgames2019/files/papers/ComputacaoFull/197880.pdf) — estudo de caso de assistência de ML em sprites de jogo de luta; resultados são situados naquele projeto, não padrão universal.
- [Sprite Sheet Diffusion (2024)](https://arxiv.org/abs/2412.03685) — pesquisa experimental para geração condicionada de folhas de sprite.

Consultar essas fontes como princípios e estudos, não como autoridade para copiar arte ou concluir que existe uma quantidade canônica de frames por ação.
