# Estado e roadmap

Última revisão: 2026-10-03. Este documento separa o protótipo que já existe dos conceitos de arte em revisão.

## Situação atual

**Base executável documentada:** Godot 4.7.2, GDScript, renderer Compatibility, viewport 1280×720. O projeto é uma luta local 1×1 para Windows, feita para jogar entre amigos.

**Protótipo:** arena lateral 2D, dois lutadores placeholder CC0, movimento, salto/agachamento, defesa, ataque, dano e rounds. Os conceitos do Jão ainda não substituem os placeholders no jogo.

**Arte do Jão:** folhas visuais estão em produção e revisão, mas não são assets finais de engine. A defesa em pé, o chute no ar e o chute lateral com a perna da frente foram aprovados visualmente. Fatiamento, pivôs, tempos, transparência e integração ainda estão pendentes. A recuperação do nocaute e a reação não letal foram criadas em 03/10 e aguardam revisão. O chute lateral com a perna de trás v06 foi reprovado e permanece pausado.

**Alice:** escolhida para ser a segunda lutadora do teste local. Conceito visual v02 aprovado pelo usuário; faixa de cabeça e roupa casual de luta confirmadas, aura rosa definida. Idle v04 aprovado visualmente. Caminhada v01 e agachar v01 considerados adequados para seguir, com revisão posterior prevista. Salto v01 criado e aguardando revisão visual. Chute leve com a perna da frente v01 e chute pesado com a perna de trás v01 aprovados visualmente. Soco leve/jab v01 aprovado visualmente, sem VFX. Soco combo 2, com o braço oposto, aprovado visualmente em 04/10. Combo 3 criado em duas folhas separadas: movimento corporal de empurrão curto e gesto para cima, e VFX dos espinhos rosa surgindo do chão. Ambos aguardam revisão visual. Fatiamento, transparência, pivôs e integração ainda pendentes. As alturas reais de Jão e Alice estão registradas em nota privada; escala de jogo fica para a integração, sem redimensionar arte agora. A ordem visual do combo de três golpes está definida; seus tempos, alcance e regras de gameplay ainda estão pendentes. A defesa em barreira também precisa de regras de gameplay. O inventário atualizado e o processo obrigatório estão em [ANIMACAO_2D.md](ANIMACAO_2D.md). A pesquisa técnica detalhada está em [ANIMACAO_2D_PESQUISA_E_PLANO.md](../JUNQ_FIGHT/ANIMACAO_2D_PESQUISA_E_PLANO.md).

**Validação conhecida:** registros anteriores relatam carregamento headless e export de build, mas o runner não confirmou claramente os testes automatizados. Execução visual, fluxo completo e teste em instalação limpa no Acer Nitro V15 ainda precisam ser registrados.

## Próximas etapas

### A — Revisar conceitos

- Revisar um movimento por vez e marcar explicitamente aprovado, reprovado ou precisa de ajuste.
- Corrigir continuidade anatômica, equilíbrio, apoio, direção e leitura antes de fatiar.
- Manter pausado o chute da perna de trás até ser refeito corretamente.

### B — Preparar as animações aprovadas

- Recortar os quadros e registrar nome, ordem, dimensões, pivô, linha-base e duração.
- Produzir PNG transparente derivado da folha chroma e verificar as bordas.
- Separar timing visual de startup, janela ativa, recovery, dano, hitstop e hitboxes.

### C — Integrar um pacote vertical

- Integrar primeiro idle, caminhada, agachamento, salto, guarda, ataque leve, reação a golpe e nocaute/recuperação.
- Validar transições, orientação para os dois lados, baseline, sombra, colisões e hitboxes na cena.
- Repetir testes da lógica de rounds e dos controles após cada integração.

### D — Validar no computador-alvo

- Abrir e jogar a build no Acer Nitro V15; conferir legibilidade em 1280×720, desempenho, áudio, instalação limpa e controles.
- Registrar os comandos executados e resultados; não declarar validado apenas por compilação ou execução headless.

### E — Fechar o MVP

- Criar o segundo lutador e finalizar uma arena autoral.
- Realizar uma sessão local com amigos e corrigir os problemas observados.
- Gerar uma build privada de Windows e preservar a versão testada.

## Depois do MVP

Modo online, rollback, CPU, tutorial, mais lutadores/arenas e opções avançadas ficam para depois de uma partida local estável e testada.

## Critério de pronto para o MVP

- Dois lutadores visualmente distintos e uma arena final.
- Partida local completa, controles entendíveis, rounds e revanche.
- Pés alinhados ao chão, agachamento sem afundar, sombra coerente no salto e sem oclusões ruins.
- Testes de regressão e sessão prolongada concluídos.
- Build instalada e aberta em ambiente limpo no computador-alvo.
- Procedência/licença de cada asset documentada.
