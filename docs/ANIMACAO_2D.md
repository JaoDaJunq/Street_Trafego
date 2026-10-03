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

- Usar uma única cor sólida e uniforme por folha de animação. O padrão é verde chroma puro (`#00FF00`), desde que essa cor não apareça no personagem, roupa, cabelo, acessórios ou contornos.
- Se o verde aparecer no personagem, escolher antes da produção outra cor sólida e saturada ausente da paleta (por exemplo, magenta `#FF00FF` ou ciano `#00FFFF`). Conferir também tons próximos nas bordas do desenho.
- Manter a mesma cor de fundo em todos os quadros da folha. Não usar gradiente, textura, iluminação, ruído, sombra, chão, borda ou texto sobre o fundo.
- Evitar contaminação da cor de recorte nas bordas do personagem. Na preparação para importar, remover a cor de fundo sem apagar pixels da arte e validar o resultado sobre o cenário do jogo.
- Registrar a cor escolhida nos metadados da folha. Transparência só deve ser usada quando uma etapa específica do pipeline exigir esse formato.

## Estado atual do pacote do Jão — 03/10/2026

As oito folhas abaixo são conceitos visuais gerados para revisão. Ainda não foram aprovadas como arte final, fatiadas com metadados definitivos ou integradas e testadas na Godot.

| Estado | Folha criada | Situação |
|---|---|---|
| Idle | 6 poses | Criada; conferir ritmo do loop e consistência com as demais. |
| Caminhada lateral | 6 poses | Criada de perfil, voltada à direita; usar a versão lateral corrigida. O rascunho de caminhada de frente foi rejeitado. |
| Down / agachar | 6 poses | 3 poses descendo e 3 mantendo a guarda baixa. A transição de volta para a posição em pé ainda não tem folha própria. |
| Jump | 6 poses | Preparação, impulso, subida, ápice, descida e aterrissagem. |
| Ataque leve / jab | 6 poses | Guarda, preparação, extensão, contato, recuo e retorno à guarda; conceito gerado, ainda aguardando revisão e integração. |
| Ataque pesado / cruzado reto | 8 poses | Guarda, carga, transferência de peso, extensão/impacto, recuo e retorno; conceito gerado, ainda aguardando revisão e integração. |
| Defesa em pé / bloqueio alto-médio | 6 poses | Conceito v01: preparação, bloqueio protegendo cabeça/parte superior, breve sustentação e retorno à guarda; aguardando revisão e integração. |
| Defesa abaixada / bloqueio baixo | 6 poses | Conceito v01: guarda agachada, preparação, antebraço protegendo linha baixa, breve impacto e retorno à guarda agachada; aguardando revisão e integração. |
| Soco abaixado / direto | 6 poses | Conceito v01: sai e retorna à guarda agachada; mantém os pés plantados e acompanha o mesmo braço durante preparação, extensão e recuo; aguardando revisão e integração. |
| Chute abaixado / chute frontal baixo | 6 poses | Conceito v01: usa a perna atacante aprovada do chute lateral da frente, com trajetória baixa; mesma perna acompanha preparação, extensão, recuo e guarda, apoio permanece plantado; aguardando revisão e integração. |
| Nocaute / reação, queda e pose final | 6 poses | Conceito v01: reação ao impacto, desequilíbrio, queda e posição final no chão; levantar permanece como animação separada. Aguardando revisão. |
| Chute lateral leve / perna da frente | 6 poses | Conceito v03: tronco gira para mostrar mais as costas; perna atacante permanece a mesma no ciclo; joelho e pé de apoio flexionam/pivotam para o golpe. Aguardando revisão. |
| Chute lateral leve / perna de trás | 6 poses | Conceito v06 reprovado pelo usuário por inconsistência na perna atacante nos quadros 2 e 4. Não integrar; revisar posteriormente. |

As folhas-conceito atuais usam canvas de 1536×1024 em grade visual 3×2 (512×512 nominais por cel). A separação exata dos cels, o pivô, a escala e a linha-base precisam ser conferidos antes da importação. Os conceitos derivados de referência pessoal permanecem fora deste repositório público.

## Decisões vinculantes para futuras artes do JUNQ FIGHT

- Este projeto é um jogo de luta **2D lateral**. Criar os personagens de perfil ou três-quartos lateral, voltados horizontalmente para o oponente. Não usar direções de jogo top-down nem desenhar o lutador de frente para a câmera.
- **Down significa agachar**: a entrada abaixa o lutador no plano lateral. Não significa caminhar em direção à parte de baixo da tela.
- Criar primeiro os sprites voltados à direita e espelhá-los horizontalmente para o lado esquerdo. Fazer arte própria para a esquerda somente se o espelhamento prejudicar detalhes assimétricos, anatomia, leitura ou silhueta.
- Para chutes laterais leves, produzir folhas separadas para a perna da frente e a perna de trás. A rotação do tronco deve acompanhar a perna usada: no chute com a perna da frente, girar quadril e ombros para longe da câmera, mostrando mais as costas; no chute com a perna de trás, girar em direção à câmera, expondo mais o peito. Não manter o tronco na pose neutra do Idle.
- Rastrear a mesma perna e o mesmo tênis atacante do início da preparação até a extensão, recuo e retorno à guarda; não trocar as pernas no meio do ciclo. O apoio precisa ser biomecanicamente coerente: joelho flexionado em direção ao golpe, pé pivotado na direção do movimento e contato com o chão estável. Na preparação e na recuperação, o apoio deve desfazer o pivô e voltar à posição/ângulo inicial sem deslizar. Conferir a sequência quadro a quadro antes de integrar.
- A imagem de Street Fighter Alpha 3 enviada pelo usuário serve somente como referência biomecânica do chute lateral; criar personagem e arte originais, sem reproduzir personagem, sprites, cenário ou interface do jogo.
- Preservar no Jão a direção visual aprovada: cabelo escuro, óculos, jaqueta varsity vinho com mangas creme, moletom claro, calça escura e tênis branco. Manter identidade, proporções, escala e guarda entre os estados.
- Usar fundo liso chroma verde puro (`#00FF00`) quando essa cor não existir no personagem ou em seus contornos. Se houver verde na arte, selecionar uma única cor alternativa ausente da paleta e registrá-la. Não adicionar gradiente, textura, brilho, sombra ou elementos de cenário ao fundo.
- Para cada conceito, guardar a folha com fundo chroma e também uma versão PNG RGBA transparente para importação e tratamento no jogo. A remoção do fundo e as bordas devem ser validadas para não apagar nem contaminar pixels do personagem.
- Fazer poses visualmente distintas e legíveis em sequência. Manter o pivô dos pés e a linha do chão nas poses apoiadas; no salto, elevar o personagem sem mover o ponto de referência do chão. Confirmar tempo por cel dentro do jogo, pois a folha não define sozinha o timing de gameplay.
- O primeiro pacote de combate deve incluir ao menos um ataque leve, um ataque pesado, bloqueio alto e baixo e uma reação visual ao bloqueio. Manter as animações separadas dos dados de startup, frames ativos, recovery e dano.
- Criar arte original. A referência a Street Fighter é de gênero e leitura de luta; não reproduzir sprites, personagens ou elementos protegidos dos jogos comerciais.

## O que falta para fechar o pacote jogável

1. Revisar e aprovar os quatro conceitos; corrigir diferenças de rosto, roupa, volume, escala, baseline e leitura do ciclo.
2. Fatiar as folhas com retângulos, nomes e durações por cel; testar os loops Idle e caminhada, a descida/hold do agachamento e o ciclo completo de salto.
3. Definir e testar a saída do agachamento. No primeiro protótipo, avaliar reproduzir ao contrário as poses de descida antes de produzir uma folha própria de levantar.
4. Revisar os conceitos de combate; produzir soco e chute no ar; tratar o levantar como animação separada.
5. Importar as versões de jogo na Godot 4.7.2; validar controles, alinhamento do chão, espelhamento esquerda/direita, colisões/hitboxes e leitura a 60 atualizações por segundo no Acer Nitro V15.

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
