# Pipeline de animação 2D para luta

Guia inicial para os personagens autorais. Não existe contagem universal de quadros por golpe ou uma única folha que todos os jogos usem. Os valores abaixo são **faixas de planejamento**, não regras oficiais.

## Princípios

- Priorizar ação legível: silhueta clara, antecipação, pose de contato forte e recuperação compreensível.
- Manter pivô do chão e escala consistentes entre cels. Revisar a sequência no jogo, não apenas cada imagem isolada.
- Separar desenhos/frames (arte) de startup, janela ativa, recovery, dano, bloqueio e hitstop (lógica). Segurar ou acelerar uma cel é decisão de timing, não necessariamente um novo desenho.
- Decidir se o sprite será espelhado ou terá arte para ambos os lados; verificar roupa, cabelo e acessórios assimétricos.
- Sombras e ponto de contato dos pés pertencem ao plano do chão; o sprite sobe no salto sem levar a sombra junto.

## Faixas iniciais para protótipo

| Estado | Cels sugeridas para rascunho |
|---|---:|
| Idle/respiração | 5–8 |
| Andar para frente/trás | 6–8 por ciclo |
| Agachar/levantar | 2–3 por transição, mais 1–3 de hold |
| Salto | 2–3 de saída, 3–5 no ar, 2–3 de aterrissagem |
| Entrar em defesa / reação de block | 2–4 cada; hold separado |
| Soco rápido / médio / forte | 4–6 / 6–8 / 7–10 |
| Chute | 6–10 |
| Reação ao golpe | 2–5 |
| Queda/nocaute/levantar | 6–12 para leitura inicial |

Combos, agarrões, vitória, derrota e movimentos especiais ampliam o conjunto. Começar por um vertical slice: idle, caminhada, agachar, salto, defesa, um soco, um chute, hit e nocaute.

## Convenção da folha e dados por golpe

Definir canvas, área segura, pivô, direção, escala e nomenclatura antes de produzir. Usar uma folha por estado ou atlas com metadados explícitos (retângulos/cels e duração); não presumir mesmo tamanho/número para todas as ações.

Cada golpe deve registrar: nome, comando, cels, duração por cel, startup, frames ativos, recovery, dano, hit/block stun, hitstop, alcance, altura (alto/médio/baixo), cancelamentos e reação. No protótipo os tempos básicos são aproximadamente 0,12 s de preparação, 0,10 s ativo e 0,24 s de recuperação, a 60 atualizações/s. É frame data do protótipo, não dado oficial de Street Fighter.

## Cenário por planos

Organizar em fundo distante, plano intermediário, chão/linha de luta e elementos de primeiro plano. Cada plano tem regra de parallax e oclusão própria. Primeiro plano deve emoldurar sem esconder os lutadores nem confundir a linha dos pés. Colisão, limites e linha do chão ficam separados da arte decorativa.

## Problemas visuais conhecidos

- **Flutuação:** pivô/offset não coincide com o chão lógico; escala e offset podem se acumular. Alinhar a sola de referência diretamente ao ground pivot.
- **Afundar ao agachar:** trocar escala vertical com offset derivado do tamanho desloca a base. Preservar pés ancorados e usar cel de agachamento desenhada com a mesma linha-base.
- **Sombra no salto:** não deixar sombra como filha que acompanha altura do corpo; mantê-la no plano do palco e variar escala/opacidade com altura.
- **Oclusão:** ajustar profundidade/Y-sort dos props; não resolver sobreposição alterando colisão dos lutadores.

## IA como assistência

Geração pode acelerar conceito, paleta e rascunho por pose; consistência de identidade, volume, pivô, proporções e sequência ainda requer direção humana e revisão quadro a quadro. Exigir arte original/direitos claros, poses nomeadas, linha-base comum, transparência limpa, correção de anatomia, teste em loop e registro da ferramenta/termos. Não reproduzir sprites comerciais protegidos.

## Leituras técnicas

- [Godot — AnimatedSprite2D](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html), [SpriteFrames](https://docs.godotengine.org/en/stable/classes/class_spriteframes.html).
- [Godot — CanvasItem e ordenação Z](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html), [Sprite2D](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html), [parallax 2D](https://docs.godotengine.org/en/stable/tutorials/2d/2d_parallax.html).
- [GDC — Animation Bootcamp: Fluid and Powerful Animation](https://www.gdcvault.com/play/1020017/Animation-Bootcamp-Fluid-and-Powerful).
- [SBGames 2019 — ML-assisted asset generation / Trajes Fatais](https://www.sbgames.org/sbgames2019/files/papers/ComputacaoFull/197880.pdf), estudo de caso situado, não padrão universal.
- [Sprite Sheet Diffusion (2024)](https://arxiv.org/abs/2412.03685), pesquisa experimental de geração condicionada.

Use essas fontes como princípios e estudos, não como autoridade para copiar arte ou declarar contagem canônica de frames.