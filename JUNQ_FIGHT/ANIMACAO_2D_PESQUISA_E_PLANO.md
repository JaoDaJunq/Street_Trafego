# Pesquisa e plano do pipeline 2D — JUNQ FIGHT

**Data:** 2026-10-02  
**Escopo:** diagnosticar a arena migrada, definir um padrão próprio de animação e preparar o próximo push de personagem. Este documento é uma especificação de produção, não uma cópia de assets, código ou animação proprietária.

## Resumo executivo

O personagem flutua principalmente por um erro matemático no `AnimatedSprite2D.offset`: o código calcula o deslocamento já multiplicado por `SPRITE_SCALE`, mas a escala do nó transforma esse deslocamento outra vez. Com a célula atual de 63 px e escala 2,4, o limite inferior da célula fica **105,84 px acima** do ponto físico dos pés (`FLOOR_Y`). A pose de agachamento repete o erro com escala diferente; além disso, usa o idle comprimido em vez de uma animação de agachar. Isso explica os dois sintomas das imagens sem culpar a física da Godot.

O modelo de luta deve separar três coisas: **arte/poses** (cels desenhadas), **duração/exposição** de cada cel e **frame data da simulação** (startup, ativo, recovery, hitstop, colisões). Não há uma contagem universal por golpe. Para nosso primeiro personagem, proponho começar com ataques de 4–8 poses-chave e uma biblioteca essencial de aproximadamente 70–110 desenhos únicos, expandindo conforme o moveset aprovado. É um alvo de produção próprio, não um número oficial de Street Fighter.

## Diagnóstico no projeto atual

| Sintoma | Evidência no código/asset | Causa e consequência |
|---|---|---|
| Personagem parece flutuar | `graybox.gd`: `SPRITE_FRAME_SIZE.y = 63`, `SPRITE_SCALE = 2.4`; offset inicial em torno da linha 306 | `offset.y = -63 × 2,4 ÷ 2 = -75,6` é um deslocamento local. Como o nó ainda tem escala 2,4, o limite inferior da célula resulta em `2,4 × (-75,6 + 31,5) = -105,84 px` em relação ao pivô. O collider termina no root em `FLOOR_Y=568`; o desenho, não. A transparência do PNG ainda pode aumentar a distância entre a última linha opaca e o chão. |
| Ao agachar o desenho afunda/desce | linhas do `_animate_fighter`: escala Y passa a `2,4 × 0,82`; offset também incorpora essa escala | O offset de agachamento é recalculado com a escala aplicada de novo. O limite inferior sai de cerca de −106 px para −60 px do root: move-se ~46 px para baixo, enquanto o desenho é achatado. Por isso parece afundar, embora a colisão mantenha os pés na linha. |
| Agachamento não parece uma pose de luta | `_animate_fighter()` seleciona `idle` quando `is_crouching` e comprime a escala Y para 0,82 | Reduzir o sprite inteiro encurta pernas e tronco juntos; não dobra joelhos/quadril, não baixa o centro de massa com anatomia e pode distorcer pixels. Precisamos de `crouch_enter`, `crouch_idle` e `crouch_exit` desenhados, ancorados pela sola. |
| Bloqueio não tem animação corporal | O asset Brawler Girl não possui `block`; o branch de animação também não seleciona animação de guarda | A defesa mecânica funciona, mas feedback visual é modulação azul/contorno de Line2D. O comentário do usuário está correto: é ausência de asset/estado visual, não falha no pacote. Prever guarda alta/baixa e reação de bloqueio. |
| Personagem fica pequeno para a referência | Folhas escolhidas são de beat-'em-up: células de 96×63 e figuras ocupando só parte da célula; escala 2,4 | A altura opaca é muito menor que a célula completa. Na captura, os lutadores ocupam uma fração do campo comparados ao exemplo de Alpha 3. Definir a altura visível em pixels da tela depois de corrigir o pivô; estimativa inicial para testar em 720p: cerca de 190–250 px, revisada com salto, HUD e distância entre lutadores. É direção visual, não padrão obrigatório. |
| Arbusto parece misturar-se ao lutador | `fore.png` é uma composição única com poste e arbustos; posição Y=160, escala 3; `z_index=-2`; lutadores ficam no Z padrão 0 | Pelo ordenamento atual, a folhagem está **atrás** dos lutadores (não à frente). Mas invade a faixa de combate e, com os pés visuais deslocados ~106 px, cria a leitura de lutador sobre/atrás do arbusto. Remover a folhagem da zona jogável ou separar arte de cenário; manter a faixa central limpa. |
| Sombra não representa a altura no salto | `GroundShadow` é filha do `CharacterBody2D` | Quando o root sobe, a sombra sobe junto. O ideal é manter sombra projetada no chão, seguindo só X, e ajustar escala/opacidade com a altura; no salto, ela informa onde o personagem aterrissará. |
| Ataque e animação não compartilham uma timeline explícita | Lógica mede 0,12 s de startup + 0,10 ativo + 0,24 recovery a 60 ticks/s; folha de jab tem 3 imagens a 14 FPS | A animação desenhada dura ~0,21 s, enquanto o estado mecânico dura ~0,46 s. O último cel pode ficar parado durante o restante do ataque. Isso é protótipo funcional, não sincronização de luta pronta. Cada ação final precisa mapear poses/exposições à timeline e eventos de hitbox. |
| Fundo e HUD competem com a leitura | A camada de cenário é fixa e inclui elementos de alto contraste; texto de instruções ocupa quase toda a borda inferior; round é pequeno | Separar planos, deixar o centro de combate com menos contraste, testar a tela em tamanho real e dar fundo/folga ao placar. A faixa inferior deve ser usada para prompts contextuais, não uma linha longa permanente.

### Correção técnica proposta (para o próximo push)

- Definir o pivô do lutador na **sola dos pés**, no espaço local da célula. Com `centered=true`, começar testando `offset.y = -cell_height / 2` (−31,5 local px), sem multiplicar pela escala; a escala do `AnimatedSprite2D` transforma esse offset junto com a textura. Confirmar com um marcador visual de baseline e com cels cujo desenho tenha transparência diferente.
- Melhor prática para as artes novas: canvas uniforme, eixo X central conhecido, linha de chão explícita (por exemplo, Y=altura−1 ou uma linha de baseline configurada) e pivô/nome de ação documentados. Alinhar cada frame pela sola, não pelo centro do retângulo opaco, porque braços, cabelos e golpes mudam a caixa visual.
- Remover o squash vertical do crouch. Trocar a animação e manter os pés no mesmo baseline; reduzir o collider a partir do chão, com o centro da cápsula/retângulo recalculado para que a borda inferior permaneça constante.
- Tornar a sombra uma projeção separada no plano do chão; associá-la ao lutador por X, não pelo Y aéreo.
- Para profundidade de props/personagens, usar `Y-sort` de forma deliberada para objetos que realmente atravessam o plano de luta; props grandes da faixa de combate devem ser afastados ou divididos em partes, não depender de uma imagem enorme única.

## Como pensar os quadros de um jogo de luta

1. **Tick lógico:** o protótipo roda a 60 ticks/s. Startup, janela ativa, recovery, stun e hitstop são contados nessa simulação. Exemplo atual: 0,12/0,10/0,24 s corresponde aproximadamente a 7/6/14–15 ticks.
2. **Cel/pose artística:** desenho distinto. Um cel pode ficar visível por vários ticks; animação “on twos” numa lógica a 60 Hz mostra um novo desenho a cada 2 ticks. Não precisamos desenhar 60 imagens diferentes por segundo.
3. **Exposição/timing:** duração que o cel permanece. Segurar a antecipação, o contato ou o overshoot dá ênfase sem adicionar dezenas de desenhos.
4. **Colisão/frame data:** caixas de hurt/hit/throw e eventos precisam estar ligadas aos ticks de gameplay, não inferidas pela posição bonita do punho no PNG. O sprite pode antecipar/ultrapassar o hitbox; os dados são inspecionados e balanceados separadamente.

A palestra de animação de *Skullgirls* na GDC dá exemplos de silhueta forte, antecipação, pose-chave, overshoot, smear e holds; uma antecipação de um desenho já pode comunicar um golpe, e o número de desenhos não precisa igualar o número de ticks. A mesma apresentação enfatiza começar por roughs ajustados às necessidades do designer e só depois finalizar. Outra palestra da GDC sobre *Treachery in Beatdown City* trata explicitamente de luta 2D animada com poucos frames e equipe pequena. Isso apoia nosso escopo enxuto, não uma folha gigantesca automática.

## Especificação artística inicial (alvo para discutir, não lei do gênero)

Números abaixo são **desenhos-chave únicos por clip**. Holds podem prolongá-los; animações espelhadas podem ser reaproveitadas se a assimetria do figurino não ficar errada.

| Estado/ação | Desenhos sugeridos | Observação de gameplay/arte |
|---|---:|---|
| Idle/stance | 5–8, loop | Respirar, peso alternando e mãos vivas; alinhar a primeira/última pose para o loop não saltar. |
| Avançar / recuar | 6–8 cada | No primeiro passe, testar se um ciclo espelhado é legível; estilos de luta podem exigir passos distintos. |
| Virada | 1–3 | Pode ser flip horizontal + pose assimétrica revisada; manter arma/acessórios no lado correto. |
| Entrar/sair do agachamento | 2–3 cada | Transições separadas evitam aparecer instantaneamente em pose baixa. |
| Agachado parado | 2–4, loop | Pose real com joelhos flexionados e cabeça/guarda baixas; baseline das solas continua igual. |
| Salto: impulsão / ar / pouso | 2–3 / 3–5 / 2–3 | Arco vertical pode ser movimento do root; desenhos dão squash, pernas recolhidas e impacto de pouso. |
| Guarda alta/baixa | 2–3 para entrar + 2–4 em loop, cada uma | Guarda visível; pode haver high/low como variantes ou estados separados. |
| Reação ao bloquear | 2–4 por guarda | Recuo curto, flash/efeito e eventual hitstop são sinais separados. |
| Jab/ataque leve | 4–6 | Silhueta clara, antecipação curta, contato legível, recuperação que retorna à guarda. |
| Soco médio/forte | 6–8 / 7–10 | Mais antecipação/overshoot e recuperação; golpes mais fortes precisam comunicar risco. |
| Chute médio/forte | 6–8 / 7–10 | Abrir silhueta da perna e controlar o equilíbrio/retorno. |
| Ataque baixo | 5–8 por golpe | Pose e altura do hurtbox/hitbox distintas do ataque alto. |
| Reação ao dano | 2–4 leve; 3–5 forte/baixo/aéreo | Tipos de reação podem compartilhar poses se a leitura e o balanceamento permitirem. |
| Queda + levantar | 4–7 + 3–6 | Separar queda, chão e invulnerabilidade/levantada mecânicas. |
| Agarrão/throw | 8–14 por participante | São dois clips sincronizados: atacante e vítima; prototipar depois do básico. |
| Vitória/derrota | 8–16 cada | Conteúdo de apresentação depois que movimento e combate estiverem aprovados. |

Para **o primeiro recorte do Jão**, recomendo não produzir todo o moveset de uma vez: idle, andar, crouch, jump/land, guarda alta, reação de block, jab, reação de hit, ataque forte e defeat/KO. Validar pivô/escala no jogo; em seguida adicionar low kick/punch e combos. Como guia de orçamento, esse pacote MVP fica em torno de 70–110 desenhos únicos dependendo de reaproveitamento; completar também todo o catálogo da tabela, incluindo throws e apresentação, pode levar o total para além de 130. Ninguém está prometendo “exatamente X frames de Street Fighter”.

### Convenção de arquivo e atlas

- Originais por clip (PNG transparente) mais atlas exportado; uma linha por clip, frames em ordem, dimensões fixas por personagem e metadados (nome, FPS base, duração por cel, loop, baseline, escala/import filter).
- Nome sugerido: `jao/idle/jao_idle_000.png`; `jao/attack/jab_light/jao_jab_light_000.png`; atlas/JSON é produto de build, não a única cópia editável.
- Cada animação deve abrir em preview em velocidade real e ser revista quadro a quadro em tamanho de jogo. Registrar pivô, hurtbox, hitbox e tick de contato por golpe numa ficha por personagem.
- Virar o sprite por `flip_h` é uma otimização; validar letras/logos, assimetria de cabelo/roupa, mão dominante, bainhas e props antes de aceitar espelhamento.

## Referência Street Fighter sem copiar conteúdo

- Street Fighter é um exemplo de linguagem: poses extremas legíveis, silhueta reconhecível, boa antecipação/impacto/recuperação e leitura do espaço de combate. Não há “sprite-sheet de Street Fighter” com número universal que possamos tratar como norma.
- O material público de produção de *Super Street Fighter II HD Remix* mostra revisão em etapas: line art, cor chapada, controle de qualidade, shading e nova revisão. A equipe aponta popping de detalhes entre cels, rotação do pé e inconsistência de linhas/sombras, além de redesenhar o que não funciona. A conclusão prática é revisar continuidade e pivô **antes** de sombrear/produzir dezenas de variantes.
- Entrevistas da equipe de *Street Fighter III: 3rd Strike* enfatizam animação/movimento como foco de identidade e mostram refinamento de footwork/hitbox em diferenças de poucos pixels. Uma entrevista de Akira Yasuda descreve reuso/adaptação de padrões de animação entre personagens e esforço excepcional de produção. Isso mostra por que copiar o volume do SFIII seria uma armadilha para o nosso escopo.
- A GDC documenta que seis desenhos podem dar um soco eficaz e que tirar frames redundantes de uma queda tornou a ação mais forte. O objetivo é pose, contraste e timing — não bater uma cota alta de cels.

## Cenário: composição que apoia a luta

Para uma arena fixa de luta, usar uma estrutura simples, com ponto de chão explícito:

1. **Fundo distante:** céu, skyline; pouco contraste e sem detalhe que pareça um lutador/hit spark.
2. **Plano médio:** fachada, luzes, objetos de ambientação; movimento/parallax discreto e desacoplado do tick competitivo.
3. **Plano de chão:** rua/dojo/plataforma e marca do baseline, consistente com as solas e colisão.
4. **Entidades de luta:** sombras projetadas no chão, fighters, hit sparks. A ordem entre fighter e props usa Y-sort só onde o cruzamento de profundidade fizer sentido.
5. **Primeiro plano:** opcional, enquadramento periférico; nunca atravessar mãos, pernas ou leitura de hitbox na zona de combate. Folhagem/veículos não devem ser colocados dentro da faixa de movimento só porque vieram na camada chamada `fore.png`.
6. **HUD:** `CanvasLayer`, contraste e espaço próprios; barras afastadas do timer/round, placar central legível, texto de controles reduzido/contextual.

No Godot, `Parallax2D` pode organizar camadas que repetem/rolam em velocidades diferentes. Para nosso protótipo sem câmera móvel, camadas estáticas bastam; primeiro acertamos escala, linha do chão, contraste e área livre. Só adicionamos parallax se der profundidade sem competir com a luta. O exemplo de *Street Fighter III* é elogiado pela qualidade dos cenários, mas os cenários ainda deixam o combate como foco.

## IA para acelerar (com controle humano)

**Casos públicos examinados**

- Um trabalho do SBGames sobre *Trajes Fatais: Suits of Fate* treinou Pix2Pix/cGAN para colorir/produzir versões de sprites a partir de sketches e avaliou resultados com artistas da equipe. O artigo descreve um pipeline em que a equipe ainda criava poses/desenhos e o ML ajudava a chegar a sprites semiprontos. Os autores identificaram inconsistência de shading entre frames, ruído de paleta e dificuldade com poses afastadas dos dados de treino.
- O artigo *Sprite Sheet Diffusion* (2024) condiciona a sequência à arte de referência e à sequência de poses; isso é mais apropriado do que pedir “uma sprite sheet pronta” no prompt. O trabalho relata progresso em alinhamento, mas também overfitting/características robóticas. É pesquisa experimental, não garantia de asset final.
- O relato de game jam de Josef Spjut/NVIDIA, publicado nos workshops da CVPR em 2025, testa assistentes de IA num jogo real e discute tanto a utilidade quanto os pontos fracos. A evidência apoia um processo humano dirigindo decisões e corrigindo saída, não um botão que entregue personagem de luta pronto.

**Pipeline que recomendo para nós**

1. Aprovar uma ficha visual do Jão: silhueta, vista lateral de combate, paleta curta, rosto/cabelo/roupa/tênis, detalhes assimétricos e referências próprias autorizadas.
2. Fazer uma folha de modelo com frente/lado/costas e proporções fixas; decidir tamanho nativo da célula e pixels visíveis do corpo em 720p. Produzir primeiro idle em loop e pose de guarda; esse é o teste de identidade.
3. Planejar clips e gameplay com key poses/mini-storyboard e ficha de frame data antes de gerar sequências: antecipação, contato/ativo, overshoot, recuperação/retorno. Anexar uma pose guia a cada frame.
4. Usar IA para explorar conceitos, variações de roupa/cor, rascunhos/poses ou preencher/limpar frames sob referência; gerar uma ação por vez. Evitar depender de uma única imagem enorme com 15 ações: o modelo pode alterar proporção, detalhes, transparência e pivot entre células.
5. Curar manualmente: comparar silhouette, olho/cabelo/roupa, anatomia, escala, linha de chão, paleta e pixels que “piscam”; reparar e exportar frames separados com transparência e atlas regular.
6. Importar em `SpriteFrames`; controlar FPS/duração de cada cel. Sincronizar clip aos ticks de startup/active/recovery e testar hitbox em modo debug. Fechar com revisão no tamanho e velocidade reais do jogo.

Critério simples para aceitar saída de IA: a mesma identidade e tamanho em todos os frames; ambos os pés voltam ao mesmo baseline quando a ação é grounded; nenhuma peça/acessório aparece/desaparece sem intenção; poses permitem ler “defende”, “leva hit” ou “ataca” em silhueta; transparência, dimensões e separação por cel conferidas. Se falhar, tratar como conceito/rascunho, não asset plug-and-play.

## Próximo push — produção do primeiro personagem

**Não migrar engine de novo.** A base continua Godot 4.7.2 + `AnimatedSprite2D`/`SpriteFrames`.

1. Corrigir ancoragem em pontos de foot baseline e squash de crouch; sombra de salto independente do root.
2. Organizar camada da rua e deixar zona central livre, usando composição de camadas sem mudar para assets proprietários.
3. Fechar mini-brief do Jão e tamanho/célula/paleta com uma pose idle e uma guarda.
4. Criar/revisar folha de modelo e primeiro pacote de clips do Jão com o pipeline IA+edição acima.
5. Conectar cada ação a estados nomeados e timing de combate; substituir placeholder no jogo.
6. Testar frame a frame: pés e sombra no chão/parábola de salto, crouch sem penetrar, bloqueio reconhecível, início/contato/retorno do jab, facing esquerdo/direito, pixels sem shimmer, distância de HUD e props.
7. Só então ampliar combos baixos, chute, throw e variações cosméticas. Criar snapshots/build de teste sem sobrescrever versões anteriores.

**Aceite:** o lutador permanece visualmente apoiado no mesmo baseline em idle/walk/crouch/block; só sai do chão no salto e pousa com feedback; guarda e hit reaction são distintos; contato mecânico coincide com pose de impacto; em jogo a 1280×720 a silhueta continua legível em ambos os lados; testes verificam collider e visual no runtime, não apenas a existência de animações.

## Fontes públicas consultadas

- Godot — [Sprite2D (offset, center e frames)](https://docs.godotengine.org/en/4.4/classes/class_sprite2d.html), [CanvasItem: Y-sort e Z-index](https://docs.godotengine.org/en/4.5/classes/class_canvasitem.html), [animação de sprites 2D](https://docs.godotengine.org/en/4.5/tutorials/2d/2d_sprite_animation.html), [AnimatedSprite2D](https://docs.godotengine.org/en/4.4/classes/class_animatedsprite2d.html), [SpriteFrames](https://docs.godotengine.org/en/4.1/classes/class_spriteframes.html), [Parallax 2D](https://docs.godotengine.org/en/4.5/tutorials/2d/2d_parallax.html).
- GDC — Mariel Cartwright/Lab Zero, [Animation Bootcamp: Fluid and Powerful Animation within Frame Restrictions](https://www.gdcvault.com/play/1020017/Animation-Bootcamp-Fluid-and-Powerful) e [slides em PDF](https://ubm-twvideo01.s3.amazonaws.com/o1/vault/GDC2014/Presentations/Cartwright_Muriel_Animation_Bootcamp_Fluid.pdf); Shawn Allen, [Animating a Complex 2D Fighting Game 3 Frames at a Time](https://www.gdcvault.com/play/1027125/Animation-Summit-Animating-a-Complex).
- Capcom — [Street Fighter art in progress: the good & the bad](https://news.capcomusa.com/lets/browse/street-fighter-art-in-progress-the-good-the-bad); fonte de processo de revisão, não licença para reutilizar os assets mostrados.
- Entrevistas de desenvolvedores, preservadas em tradução — [SFIII: 3rd Strike](https://shmuplations.com/sfiii/) e [Akira Yasuda](https://shmuplations.com/akirayasuda/).
- Pesquisa brasileira — [Machine-Learning Assisted Asset Generation for Games: pixel-art sprites no pipeline de Trajes Fatais (SBGames 2019)](https://www.sbgames.org/sbgames2019/files/papers/ComputacaoFull/197880.pdf).
- Pesquisa de difusão — [Sprite Sheet Diffusion: Generate Game Character for Animation](https://arxiv.org/abs/2412.03685).
- Caso de game jam — [A Generative AI Game Jam Case Study from October 2024 (NVIDIA/CVPRW 2025)](https://openaccess.thecvf.com/content/CVPR2025W/CV2/html/Spjut_A_Generative_AI_Game_Jam_Case_Study_from_October_2024_CVPRW_2025_paper.html).
- Assets de protótipo licenciados — [Streets of Fight CC0 (OpenGameArt)](https://opengameart.org/content/streets-of-fight) e [Dojo Jim CC0](https://opengameart.org/content/dojo-jim); as folhas atuais não são os personagens finais e não definem o estilo do Jão.

**Limites da pesquisa:** frametimes e contagens por clip variam por personagem, versão, gênero visual, hardware e regra de gameplay; as faixas acima são orçamento inicial para um jogo pequeno. Não se buscou nem incorporou dumps, sprites ou código vazados/proprietários. Licença de código de engine independente não licencia assets de franquia.
