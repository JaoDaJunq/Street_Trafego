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

### Animação idle v04 — aguardando revisão

Criada em 03/10/2026 para tornar a transferência de peso do apoio traseiro para o dianteiro mais legível, mantendo a guarda dos braços fixa. A proposta preserva os dois braços, os pés apoiados e movimenta levemente cabelo e pontas da faixa. Perfil para a direita, aura rosa e folha visual 3×2. Ainda é conceito, não está fatiada ou integrada; a arte permanece privada.

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
