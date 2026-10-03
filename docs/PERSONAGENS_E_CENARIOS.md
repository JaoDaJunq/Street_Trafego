# Personagens e cenários

Registro criativo de produção. A arte final será original; sprites licenciados existentes continuam sendo placeholders até a aprovação e integração dos personagens próprios.

## Lutador 1 — Jão (nome de trabalho)

- **Papel:** protagonista/jogador, com identidade urbana e humor leve, reconhecível entre amigos.
- **Brief visual aprovado como direção, não como modelo final:** jaqueta varsity vinho e creme, moletom claro, calça escura, tênis branco; silhueta jovem e esportiva. Evitar mochila/alça atravessada. A referência de aparência pessoal fica privada e não é versionada neste repositório público.
- **Direção de luta:** stance compacta de boxe de rua, guarda legível, passos curtos; golpes devem enfatizar peso e personalidade sem perder leitura em pixel art.
- **Primeiro pacote de animações:** idle, andar, virada, agachar/levantar, salto/aterrissagem, guarda alta/baixa, reação de bloqueio, jab, golpe forte, reação ao dano e K.O.
- **Critério de aprovação:** manter rosto/roupa/silhueta consistentes, baseline das solas fixo e sprites legíveis no tamanho real do jogo.

## Lutadora 2 — Alice (selecionada para o teste 1×1)

Alice está confirmada como o segundo personagem do teste local. O nome está definido; aparência de combate, roupa, paleta, silhueta, personalidade de luta e golpes ainda precisam de decisão. Não tratar ideias antigas do assistente como escolhas aprovadas.

### Brief a fechar

- **Referência visual:** foto autorizada de Alice, concept anterior escolhido por vocês ou criação estilizada sem buscar semelhança direta. Referências pessoais e artes derivadas delas ficam fora do repositório público.
- **Visual:** cabelo/rosto, roupa de luta, paleta principal, calçado e um detalhe que a diferencie do Jão. Definir também itens que não devem aparecer.
- **Identidade de combate:** distância preferida, postura/guarda, movimentação, membro dominante e sensação que a luta deve transmitir. Não presumir armas, poderes ou tema de nail art.
- **Compatibilidade para teste:** mesma câmera lateral, altura visual comparável, baseline/pivô compartilhado, leitura clara de guarda e ataques, arte-base virada à direita. Revisar flip horizontal antes de usar à esquerda.
- **Kit mínimo para jogar com dois personagens:** idle, caminhada, agachar/voltar, salto/aterrissagem, guarda alta e baixa, ataque leve, ataque forte, reação a golpe, nocaute e recuperação. Socos/chutes no ar e variantes extras entram no pacote se forem necessárias para testar os comandos correspondentes.

### Processo

1. Escolher e aprovar a referência e o brief visual antes de desenhar a folha de modelo.
2. Aprovar uma pose lateral neutra e a guarda da Alice, comparando escala e linha dos pés com o Jão.
3. Produzir uma animação por entrega pelo processo do [guia de animação 2D](ANIMACAO_2D.md): storyboard, conceito, revisão quadro a quadro, aprovação explícita, fatiamento e integração.
4. Testar Alice e Jão na mesma arena, no mesmo enquadramento e nos dois lados, conferindo escala, baseline, hitboxes, leitura e desempenho.
5. Guardar conceitos baseados em referência pessoal fora do GitHub público; versionar no repositório apenas documentação e arquivos que não exponham referência pessoal, conforme a política do projeto.

### Informações que faltam para começar a arte

- Uma referência visual aprovada por Alice ou um concept anterior escolhido por vocês.
- Roupa de luta: baseada no estilo cotidiano dela, roupa totalmente original de fighter ou mistura.
- Paleta e elementos visuais que representam Alice, além do que evitar.
- Estilo de luta preferido e como deve se movimentar.
- Um golpe ou gesto assinatura para diferenciá-la do Jão.

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
