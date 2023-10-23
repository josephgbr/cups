# cups-pt_BR

> *Here you will find history and progress of translation of CUPS (https://www.cups.org) for Brazilian Portuguese (pt_BR).*

Aqui você encontra histórico e progresso da tradução do CUPS (https://www.cups.org) para português brasileiro (pt_BR). Após concluído, essa tradução é enviada para a Equipe de Desenvolvimento do CUPS para se armazenar no código-fonte e a próxima versão estará traduzido.

## Organização de diretórios:

* *cups-VERSÃO* - Diretório de código-fonte do CUPS da versão `VERSÃO`. Haverá pelo menos dois diretórios: um diretório contendo uma versão anterior usada para efeito de comparação e outro diretório no qual se realizará tradução a ser finalizada e submetida aos desenvolvedores.

* *old-versions* - Diretório contendo tarballs de versões anteriores do CUPS que já foram traduzidas para português brasileiro

* *translation*  - Guia do tradutor do CUPS traduzido para português, incluindo, dentro do subdiretório `src`, procedimentos para atualizar e outros arquivos fontes.

* *scripts*      - Diretório contendo scripts auxiliares para facilitar as tarefas de tradução

## Como posso ajudar

### Apontar correções ortográficas
Pode acontecer de algum erro, como de concordância ou de gramática. Se você encontrar algum erro, por favor comunique para que seja corrigido.

### Sugerir melhorias
Tem alguma ideia como melhorar o processo de tradução ou a própria tradução? Documentação brasileira a ser melhorada? Por favor, relate!

### Traduzir
Contribuições com tradução são muito bem-vindas. Para traduzir deve-se observar alguns detalhes:

### Discuta
Opiniões são bem-vindas. Sinta-se à vontade para contatar outros participantes na grupos de discussão _traducao-cups-pt-br_: https://groups.google.com/forum/#!forum/traducao-cups-pt-br (uma conta Google é necessária para participar)

**Requisitos**:
* Ler o guia do tradutor, seja [nossa versão não-oficial traduzida](guia-do-tradutor.md), seja a [versão original em inglês](https://www.cups.org/doc/translation.html).
* Ter conhecimento básico de Git e de tratamento de repositório Git; caso não saiba, por favor consulte a [documentação oficial do Git](https://git-scm.com/doc))
* Contribuir com arquivos no formato compatível com UNIX, ou seja, que contenham caracteres de nova linhas tipo "\n" em vez de CRLF. Sse você usar outro sistema para traduzir, certifique-se de contribuir com formato compatível com UNIX o seu editor de texto (p.ex.: [Notepad++](https://notepad-plus-plus.org/) é um editor de texto para MS Windows com vários recursos e respeita o formato )

## Procedimento de tradução

> Este detalhamento de procedimento presume já ter lido e conhecer as instruções no guia do tradutor

> *cups_ATUAL* refere-se à versão alvo de tradução, enquanto *cups_ANTIGA* se refere a última versão já traduzida e submetida ao desenvolvedor.

* Identifique o que mudou de uma versão para outra usando aplicativo de comparação, que possibilite a comparação entre os diretórios *cups_ANTIGA* e o *cups_ATUAL*. Exemplos de aplicativos são [colordiff](https://www.colordiff.org/), [Kompare](https://www.kde.org/applications/development/kompare/), [Meld](http://meldmerge.org/) ou até o próprio [diff](https://www.gnu.org/software/diffutils/). Nesta comparação, preste atenção especial para o arquivo _desktop/cups.desktop_ e os arquivos modelos _.tmpl_
 
* A tradução do catálogo de mensagens (_po/pt_BR.po_) pode ser coordenada usando a plataforma de tradução Transifex. Para participar, é necessário criar uma conta no Transifex e solicitar entrada na equipe de tradução nesta plataforma. Acesse o projeto em: https://www.transifex.com/rafaelff1/cups-pt-br/dashboard/


