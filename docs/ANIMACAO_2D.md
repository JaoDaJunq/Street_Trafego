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

## Fundo sólido para recorte

- O fundo padrão de cada folha é uma cor sólida, uniforme e ausente do personagem e dos contornos. Usar verde chroma puro (`#00FF00`) quando não houver verde na arte; se houver, escolher e registrar outra cor saturada que não exista na paleta.
- Não colocar chão, sombra, gradiente, textura, iluminação, ruído, borda ou texto no fundo da folha.
- A folha chroma é a referência de revisão. Só depois da aprovação remover o fundo para criar o PNG com transparência destinado à importação; conferir bordas para não apagar nem contaminar pixels do personagem.
- Uma folha pode ser um conceito visual sem ser uma spritesheet pronta. O grid aparente não garante cortes, pivôs, escala ou durações corretos.

## Estado atual das animações do Jão — 03/10/2026

Os conceitos foram criados para análise visual. **Aprovação visual não significa que a animação está fatiada, importada ou pronta no jogo.** As versões atuais para revisão estão no espaço de trabalho privado; desenhos baseados na referência pessoal do Jão não são publicados no repositório público.

| Ação | Versão / poses | Estado |
|---|---|---|
| Idle | v01, 6 poses | Criado; revisão visual pendente. |
| Caminhada lateral | v02, 6 poses | Criada de perfil para a direita; revisão visual pendente. A caminhada de frente foi rejeitada. |
| Agachar / Down | v01, 6 poses | Criado; revisar entrada e guarda baixa. Saída do agachamento precisa de transição própria ou teste de reversão. |
| Salto | v01, 6 poses | Criado; revisão visual pendente. |
| Jab / ataque leve | v02, 6 poses | Criado; revisão visual pendente. |
| Cruzado / ataque pesado | v01, 8 poses | Criado; revisão visual pendente. |
| Defesa em pé | v01, 6 poses | **Aprovado visualmente**; fatiamento e integração pendentes. |
| Defesa abaixada | v01, 6 poses | Criada; revisão visual pendente. |
| Soco abaixado | v01, 6 poses | Criado; revisão visual pendente. |
| Chute abaixado | v01, 6 poses | Criado; revisão visual pendente. |
| Soco no ar | v01, 6 poses | Criado; revisão visual pendente. |
| Chute no ar | v01, 6 poses | **Aprovado visualmente**; fatiamento e integração pendentes. |
| Nocaute | v01, 6 poses | Reação, queda e pose no chão; revisão visual pendente. Levantar é outra animação. |
| Recuperação do nocaute | v01, 6 poses | Criada agora; revisão visual pendente. |
| Reação a golpe não letal | v01, 6 poses | Criada agora; revisão visual pendente. |
| Chute lateral com a perna da frente | v03, 6 poses | **Aprovado visualmente**; fatiamento e integração pendentes. |
| Chute lateral com a perna de trás | v06, 6 poses | **Reprovado**: nos quadros 2 e 4 a perna que sobe é a errada. Não integrar; está pausado para refazer depois. |

As folhas de seis poses recentes usam canvas de 1536×1024 com grade visual 3×2 e células nominais de 512×512. Essa medida é de conceito: cada cel precisa ser conferida e recortada antes de virar asset. A folha de oito poses deve ser tratada conforme seu leiaute real, sem presumir o mesmo grid.

## Estado das animações da Alice — 03/10/2026

| Ação | Versão / poses | Estado |
|---|---|---|
| Conceito visual | v02 | Aprovado; aura rosa. |
| Idle | v04, 6 poses | Aprovado visualmente; fatiamento, transparência, pivôs e integração pendentes. |
| Caminhada lateral | v01, 6 poses | Criada de perfil para a direita, ciclo em grade visual 3×2 e fundo chroma verde; revisão visual pendente. Ainda não está fatiada ou integrada. |
| Agachar / Down | v01, 6 poses | Criado para revisão: descida até a guarda baixa, pés apoiados; retorno para ficar em pé será outra animação. Ainda não aprovado nem integrado. |
| Salto e aterrissagem | — | Pendente. |
| Defesa em pé/barreira e defesa baixa | — | Pendente; definir a leitura visual da barreira. |
| Socos leve e pesado | — | Pendente. |
| Chutes básicos | — | Pendente de confirmação no moveset da Alice. |
| Ataques baixos e no ar | — | Pendente para paridade do pacote de combate. |
| Combo mágico de três socos | — | Pendente; sequência e efeito rosa ainda precisam ser desenhados. |
| Reação a golpe, nocaute e recuperação | — | Pendentes. |

A caminhada e o idle estão em revisão visual como conceitos. As artes derivadas da referência pessoal da Alice permanecem privadas e não são publicadas neste repositório.

## Decisões visuais que não podem se perder

- O JUNQ FIGHT é luta 2D lateral. Desenhar Jão em perfil ou três-quartos lateral, voltado horizontalmente ao oponente. “Down” é agachar, não andar para baixo da tela.
- Preservar identidade do Jão: cabelo escuro, óculos, jaqueta varsity vinho com mangas creme, moletom claro, calça escura e tênis branco. Manter escala, proporções, rosto, roupa e guarda coerentes entre estados.
- Gerar primeiro voltado para a direita. Espelhar para esquerda só depois de conferir acessórios, assimetrias, mão dominante, silhueta e anatomia.
- Em cada ataque, identificar qual mão/perna ataca e manter a mesma durante antecipação, contato, recuo e retorno. Não trocar membros entre quadros.
- Nos chutes laterais, o tronco e a pelve giram junto com a perna usada. Chute da frente mostra mais as costas; chute de trás expõe mais o peito. O pé de apoio flexiona e pivota na direção do golpe, permanece plantado e retorna ao ângulo inicial sem deslizar.
- Em movimentos apoiados, manter o ponto de apoio e a sola coerentes. Em salto, separar altura do corpo da sombra projetada no chão.
- A referência enviada de Street Fighter Alpha 3 é apenas referência biomecânica. Personagens, animações, cenários, interface e áudio devem ser originais ou licenciados. O jogo não é afiliado à Capcom.

## Processo obrigatório para cada animação

1. **Definir a ação:** nome, objetivo de gameplay, lado para o qual o personagem olha e número de poses desejado. Uma ação por entrega.
2. **Planejar a sequência:** escrever o que acontece em cada quadro e indicar membro atacante, apoios no chão, direção do peso e pose final. Em ações com membros alternados, marcar a identidade do membro em todos os quadros.
3. **Gerar um conceito:** manter uma referência visual aprovada, a grade combinada e o fundo chroma. Não tentar fechar várias ações na mesma folha.
4. **Revisar quadro a quadro:** verificar identidade, anatomia, continuidade dos membros, equilíbrio, contatos com o chão, silhueta e leitura do começo ao fim. Rejeitar ou corrigir quadros com troca de perna/mão, pé flutuante ou pivô impossível.
5. **Registrar a decisão do usuário:** aprovado, reprovado ou pedido de ajuste. Não tratar silêncio nem geração concluída como aprovação.
6. **Finalizar a arte aprovada:** cortar as cels, padronizar área/pivô/baseline, remover o chroma, salvar PNG transparente e registrar nomes, dimensões, ordem e duração de cada cel. Guardar também a folha chroma como referência.
7. **Integrar na Godot:** importar via `SpriteFrames`/`AnimatedSprite2D`, definir timing e estados de gameplay separadamente da arte e configurar hitboxes/hurtboxes por dados explícitos.
8. **Validar no jogo:** testar loop e transições em 1280×720, facing nos dois lados, contato com o chão, hitboxes no tick correto, leitura a velocidade real e estabilidade no Acer Nitro V15. Registrar comando, resultado e defeitos encontrados.
9. **Versionar e avançar:** salvar a versão aprovada e o resultado dos testes. Só então passar à próxima ação; alterações posteriores criam nova versão sem apagar a reprovada.

### Checklist de aprovação visual

- O mesmo personagem e roupa aparecem em todos os quadros.
- Cada pose é distinta e a ação pode ser entendida só pela silhueta.
- O membro atacante é o mesmo durante o ciclo.
- O membro de apoio tem peso, flexão, contato e retorno coerentes.
- Não há troca de perna/mão, deslizamento involuntário, flutuação ou quadro que antecipe outra ação.
- A orientação lateral e o chroma permanecem consistentes.
- O último quadro retorna ao estado correto ou conecta claramente ao próximo estado.

### Pendências antes de considerar o pacote de animação jogável

1. Revisar as folhas ainda sem aprovação explícita: idle, caminhada, agachar, salto, jab, cruzado, defesa abaixada, soco abaixado, chute abaixado, soco no ar, nocaute, recuperação e reação não letal.
2. Fatiar e preparar para engine as três folhas aprovadas: defesa em pé, chute no ar e chute lateral da perna da frente.
3. Definir/corrigir entrada e saída do agachamento e confirmar transições de todas as animações para guarda, salto, queda e recuperação.
4. Depois da aprovação, criar os arquivos transparentes, metadados de corte/pivô/duração e as fichas de frame data.
5. Integrar uma ação por vez na Godot e testar baseline, espelhamento, colisão, hitboxes, timing, loops, desempenho e regressões no protótipo.
6. Manter pausado o chute lateral da perna de trás até refazê-lo com a perna atacante e o pé de apoio corretos.

## Cenário por planos

Organizar cenário em fundo distante, plano intermediário, plano de luta/chão e elementos de primeiro plano. Cada plano tem velocidade/parallax e regra de oclusão próprias. O primeiro plano deve emoldurar sem encobrir os lutadores nem confundir a linha dos pés. Manter colisão, limites e linha de chão separados da arte decorativa.

## Correções visuais antes de produzir em escala

- **Flutuação:** pivô/offset do sprite não coincide com o chão lógico; escala e offset podem ser aplicados duas vezes. Alinhar a sola de referência diretamente ao ground pivot.
- **Afundar ao agachar:** alterar escala vertical com offset derivado do tamanho pode deslocar a base. Manter pés ancorados e trocar para uma cel de agachamento desenhada com a mesma linha-base.
- **Sombra no salto:** não deixar sombra como filha que acompanha a altura do corpo; posicioná-la no plano do palco e ajustar apenas a elipse/opacidade com a altura.
- **Oclusão:** ajustar profundidade e Y-sort dos props; não resolver sobreposição visual alterando colisão dos lutadores.

## IA como assistência, não fonte de verdade

Geração de imagem pode acelerar conceito, exploração de paleta ou rascunho por pose, mas consistência de identidade, volume, pivô, proporções e sequência temporal ainda requer direção humana e revisão quadro a quadro. Requisitos do pipeline: arte original ou com direitos claros, referência aprovada, personagem/roupa fixados, poses nomeadas, linha-base comum, fundo chroma sólido uniforme conforme a convenção acima, correção de anatomia, teste em loop e registro da ferramenta/termos usados. Não alimentar ou reproduzir sprites comerciais protegidos.

## Leituras técnicas

- [Godot — AnimatedSprite2D](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html) e [SpriteFrames](https://docs.godotengine.org/en/stable/classes/class_spriteframes.html).
- [Godot — CanvasItem e ordenação Z](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html), [Sprite2D](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html) e [parallax 2D](https://docs.godotengine.org/en/stable/tutorials/2d/2d_parallax.html).
- [GDC — Animation Bootcamp: Fluid and Powerful Animation](https://www.gdcvault.com/play/1020017/Animation-Bootcamp-Fluid-and-Powerful) — princípios gerais de animação de luta.
- [SBGames 2019 — ML-assisted asset generation / Trajes Fatais](https://www.sbgames.org/sbgames2019/files/papers/ComputacaoFull/197880.pdf) — estudo de caso de assistência de ML em sprites de jogo de luta; resultados são situados naquele projeto, não padrão universal.
- [Sprite Sheet Diffusion (2024)](https://arxiv.org/abs/2412.03685) — pesquisa experimental para geração condicionada de folhas de sprite.

Consultar essas fontes como princípios e estudos, não como autoridade para copiar arte ou concluir que existe uma quantidade canônica de frames por ação.
