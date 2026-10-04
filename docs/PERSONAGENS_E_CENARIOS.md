# Personagens e cenários

Registro criativo de produção. A arte final será original; sprites licenciados existentes continuam sendo placeholders até a aprovação e integração dos personagens próprios.

## Lutador 1 — Jão (nome de trabalho)

- **Papel:** protagonista/jogador, com identidade urbana e humor leve, reconhecível entre amigos.
- **Brief visual aprovado como direção, não como modelo final:** jaqueta varsity vinho e creme, moletom claro, calça escura, tênis branco; silhueta jovem e esportiva. Evitar mochila/alça atravessada. A referência de aparência pessoal fica privada e não é versionada neste repositório público.
- **Direção de luta:** stance compacta de boxe de rua, guarda legível, passos curtos; golpes devem enfatizar peso e personalidade sem perder leitura em pixel art.
- **Primeiro pacote de animações:** idle, andar, virada, agachar/levantar, salto/aterrissagem, guarda alta/baixa, reação de bloqueio, jab, golpe forte, reação ao dano e K.O.
- **Critério de aprovação:** manter rosto/roupa/silhueta consistentes, baseline das solas fixo e sprites legíveis no tamanho real do jogo.

## Lutadora 2 — Alice (selecionada para o teste 1×1)

Alice está confirmada como o segundo personagem para o teste local. A foto de referência foi fornecida para esta criação e permanece privada, fora do repositório público.

### Direção confirmada pelo usuário

- Misturar o estilo cotidiano dela com roupa original de lutadora.
- Usar uma faixa de luta na cabeça ou detalhe equivalente.
- Priorizar socos rápidos.
- Explorar poderes ligados aos golpes, incluindo a ideia de um combo de três socos que libera energia.
- A defesa poderá usar uma barreira.
- Cores/detalhes específicos e golpe assinatura ainda não foram definidos.

### Conceito visual v02

**Aprovado pelo usuário em 03/10/2026.** A v01 teve apenas a cor da aura corrigida a pedido do usuário. Alice aparece com cabelo castanho claro longo, óculos, blusa vinho, calça larga escura, tênis claro e faixa de luta vinho. A roupa mistura referências do estilo cotidiano com elementos de lutadora. A aura nos punhos foi alterada para rosa por decisão do usuário.

A referência e a arte derivada permanecem no espaço de trabalho privado. Este repositório público registra o brief e o estado, sem publicar a imagem pessoal.

### Animação idle v01 — reprovada

O usuário apontou que as seis poses pareciam praticamente iguais. Não usar esta versão no jogo.

### Animação idle v02 — reprovada

O usuário identificou duplicação de braço e movimento exagerado em relação à base da personagem. Não usar esta versão no jogo.

### Animação idle v03 — reprovada

A troca de peso entre as pernas ficou quase imperceptível. Não usar esta versão no jogo.

### Animação idle v04 — aprovada visualmente

Aprovada pelo usuário em 03/10/2026. A folha mostra a transferência sutil de peso do apoio traseiro para o dianteiro, mantendo a guarda dos braços fixa, os pés apoiados e movimento leve no cabelo e nas pontas da faixa. Perfil para a direita, aura rosa e folha visual 3×2. Ainda precisa ser fatiada, ter transparência e pivôs preparados e ser integrada ao jogo; a arte permanece privada.

### Caminhada lateral v01 — aceita provisoriamente

O usuário considerou a caminhada adequada para seguir em 03/10/2026, com revisão mais detalhada prevista para depois. Ciclo de seis poses em perfil para a direita, guarda de combate, aura rosa e fundo chroma verde. A folha permanece privada; fatiamento e integração continuam pendentes.

### Agachar / Down v01 — aceito provisoriamente

O usuário considerou o agachamento adequado para seguir em 03/10/2026, com revisão mais detalhada prevista para depois. Criado em seis poses, da guarda em pé até a posição baixa, com os pés apoiados. A animação de voltar a ficar em pé será produzida separadamente. Fatiamento e integração continuam pendentes.

### Salto v01 — aguardando revisão

Criado em 03/10/2026 em seis poses, da preparação e impulsão até o ápice, descida e aterrissagem. Perfil para a direita, aura rosa e fundo chroma verde. A folha permanece privada, sem aprovação visual, recorte ou integração.

### Chute leve com a perna da frente v01 — aguardando revisão

Criado em 03/10/2026 em seis poses, com chute frontal da perna da frente, guarda de combate e pé de apoio no chão. Conferir continuidade da perna atacante e pivô do apoio antes de aprovar. Folha privada, ainda sem fatiamento ou integração.

### Chute pesado com a perna de trás v01 — aguardando revisão

Criado em 03/10/2026 em seis poses, com chute lateral da perna de trás. Revisar quadro a quadro se a perna atacante permanece a mesma, se o tronco gira junto e se o pé de apoio pivota e retorna sem deslizar. Folha privada, ainda sem fatiamento ou integração.

### Soco leve (jab) v01 — aguardando revisão

Criado em 03/10/2026 em seis poses. A folha mostra somente o movimento corporal, sem aura, rastro ou efeito de energia. O efeito mágico do golpe será produzido como sprite separado, conforme decisão do usuário. Arte privada; aprovação visual, fatiamento e integração pendentes.

### Brief ainda a fechar

- Definir postura/guarda, lado dominante, movimento e alcance preferido.
- Transformar o combo mágico de três socos e a barreira em regras de gameplay após fechar os estados básicos.
- Definir um golpe/gesto assinatura futuramente; nenhum foi escolhido por enquanto.
- Manter altura visual, pivô/linha dos pés, câmera lateral e proporção compatíveis com o Jão. As alturas reais e a proporção de referência estão guardadas em nota privada; não redimensionar os sprites agora. Ajustar escala de jogo só na integração.

### Processo de produção

1. Aprovar/corrigir o conceito visual antes da folha de modelo.
2. Fechar pose lateral neutra e guarda da Alice, comparando escala e baseline com o Jão.
3. Produzir uma animação por entrega pelo [guia de animação 2D](ANIMACAO_2D.md): planejar poses, gerar conceito, revisar quadro a quadro, registrar aprovação, fatiar e integrar.
4. Para o primeiro teste 1×1, cobrir idle, caminhada, agachar/voltar, salto/aterrissagem, defesa alta/baixa, ataque leve/forte, reação a golpe, nocaute e recuperação. Adicionar combo mágico e barreira depois que os estados básicos estiverem jogáveis.
5. Testar Alice e Jão na mesma arena, nos dois lados, verificando escala, baseline, hitboxes, leitura e desempenho.
6. Manter foto e arte derivada fora do GitHub público; versionar apenas materiais que não exponham a referência pessoal, conforme a política do projeto.

## Personagens placeholder

- **P1:** Brawler Girl do pacote Streets of Fight no protótipo 2D atual.
- **P2:** Enemy Punk do mesmo pacote.
- Ambos permanecem exclusivamente como referência jogável temporária. Licença e fonte constam em [Arte, assets e licenças](ARTE_ASSETS_E_LICENCAS.md).

## Arena inicial — Noite na Cidade

- **Conceito:** rua urbana à noite, luzes de prédios/neon, profundidade por camadas, calçada/asfalto e alguns elementos de rua.
- **Estado:** graybox visual montada com assets CC0 do pacote Streets of Fight; composição é provisória.
- **Regra de leitura:** centro e linha de combate limpos; contraste dos personagens acima do fundo; vegetação/postes não podem invadir a área de ação ou encobrir os pés.
- **Planos:** fundo distante (prédios/luzes), plano intermediário (fachadas e props), chão/linha de luta (colisão separada da arte) e primeiro plano opcional, com oclusão e parallax revisados.
- **Expansões futuras:** arenas com identidade do grupo, mantendo arte original/licenciada e sem objetos que prejudiquem hitboxes, orientação ou leitura do combate.

## Ideias de conteúdo

Movimentos baixos e combos ficam planejados para depois de validar guarda alta/baixa, hitboxes e o pacote básico de animação. Vitória/derrota, apresentação, efeitos por personagem e cenários adicionais pertencem à fase de vertical slice/MVP, não ao graybox atual.
