# Traduzindo e Personalizando o CUPS

Graças ao uso extensivo de modelos, imagens e catálogos de mensagens, o CUPS pode
ser facilmente traduzido (ou personalizado!) para atender às suas necessidades.
Este arquivo de ajuda irá guiá-lo através dos arquivos de localização CUPS para
que você possa aproveitar ao máximo.

## Primeiros passos

Comece baixando o código-fonte CUPS de [www.cups.org](https://www.cups.org/).
Depois de extrair os arquivos do pacote fonte (ou clonar o repositório Git),
você vai querer copiar os seguintes arquivos e diretórios:

* *desktop/cups.desktop* - o arquivo desktop do GNOME/KDE apontando para a
interface web do CUPS
* *doc/index.html.in* - a página inicial da interface web
* *locale/cups.pot* - o catálogo de mensagens
* *templates/*.tmpl* e *templates/header.tmpl.in* - os arquivos modelos da
interface web

Com exceção dos catálogos de mensagens e do arquivo desktop, os arquivos de
localização são colocados em subdiretórios sob doc e templates usando o nome da
localidade. Os nomes das localidades são *ll* ou *ll_CC*, sendo "ll" o código de
idioma de 2 letras e "CC" o código de país de 2 letras. *CUPS atualmente não usa
nem oferece suporte à nova sintaxe ll-região para nomes de localidade.*

Todos os arquivos não imagem devem ser codificados usando o conjunto de
caracteres UTF-8.

## Enviando uma tradução para o CUPS

Para enviar uma tradução para inclusão no CUPS, traduza o arquivo desktop, todos
os arquivos de modelos, o arquivo *index.html.in* e o catálogo de mensagens.
Coloque esses arquivos nos subdiretórios corretos no arquivo de código-fonte do
CUPS e execute o seguinte comando para criar um arquivo com seus arquivos:

    tar cvf _ll_CC_.tar.gz desktop/cups.desktop doc/ _ll_CC_ locale/cups_ _ll_CC_.po templates/ _ll_CC_

Substitua "ll_CC" pelo nome da localidade para sua tradução. Depois de criar o
arquivo, acesse a [página do projeto CUPS](https://github.com/apple/cups) e
submeta um relatório de erro, anexando a tradução ao relatório.

Alternativamente, você pode clonar o projeto CUPS no GitHub, fazer suas
alterações e submeter uma pull request a partir do mesmo link.

## O arquivo desktop

O arquivo *desktop/cups.desktop* fornece um link para a interface web do CUPS a
partir de ambientes de desktop, como o GNOME e o KDE. Para traduzir este
arquivo, adicione duas linhas na parte inferior com as chaves `Name` e `Comment`:

    Name[ _ll_CC_ ]= _Translation of "Manage Printing"_
    Comment[ _ll_CC_ ]= _Translation of "CUPS Web Interface"_

## A página inicial

O arquivo *index.html.in* é um arquivo HTML completo que é exibido quando o
usuário visita "http://localhost:631/". Edite o *doc/index.html.in* existente e
guarde-o no subdiretório *doc/ll_CC* para que o script *configure* possa
instalá-lo. Após configurá-lo, execute "make install" no subdiretório *doc* para
testar a nova página inicial.

## Catálogos de mensagens

Os catálogos de mensagens do CUPS são arquivos de texto GNU gettext ".po" que
fornecem uma lista de cadeias de mensagens (ou "strings") localizadas para o
software CUPS. Os catálogos de mensagens são denominados *cups_ll.po* ou
*cups_ll_CC.po*, sendo "ll" a abreviatura padrão de 2 letras para o idioma e
"CC" é o padrão de 2 letras abreviatura para o país.

Ao traduzir um novo catálogo de mensagens, copie o arquivo de catálogo de
mensagens *cups.pot* no subdiretório *locale* do código-fonte do CUPS. Por
exemplo, para começar a traduzir o catálogo de mensagens para francês canadense,
digite os seguintes comandos:

    cd locale
    cp cups.pot cups_fr_CA.po

Alternativamente, você pode copiar o catálogo de mensagens existente *cups_fr.po*
e então fazer quaisquer alterações necessárias.

Depois de ter feito a sua cópia do arquivo, edite-o usando seu editor de texto
favorito ou programa de tradução para traduzir o texto para o idioma desejado.

Em seguida, valide sua tradução usando o utilitário *locale/checkpo*:

    cd locale
    ./checkpo cups_ll_CC.po

Depois de corrigir quaisquer erros na sua tradução, adicione a sua localidade à
variável `LANGUAGES` no arquivo *Makedefs* e execute o comando "make install" no
subdiretório *locale* para testar a tradução. *Essa variável é automaticamente
atualizada quando você executa o script configure.*

## Arquivos de modelo

O agendador CUPS fornece uma interface web que pode ser usada para fazer muitas
tarefas comuns de impressão e administração. O servidor web incorporado oferece
suporte a localização de páginas web através do uso de subdiretórios para cada
localidade, p.ex. "fr" para francês, "de" para alemão, "fr_ca" para francês no
Canadá, e assim por diante.

Os arquivos de modelo são arquivos HTML com caracteres de formatação especial
neles que permitem a substituição de variáveis e arrays. Os programas CGI do
CUPS (`admin.cgi`, `classes.cgi`, `help.cgi`, `jobs.cgi` e `printers.cgi`) usam
esses arquivos de modelo para fornecer conteúdo dinâmico para a interface da
web. Os arquivos de modelo são instalados no diretório
*/usr/share/cups/templates* por padrão. A [tabela 1](table1) lista os vários
arquivos de modelo e sua finalidade.

As versões traduzidas dos arquivos de modelo devem ser salvas no subdiretório
*templates/ll_CC*. Por exemplo, os arquivos de modelo de francês canadense devem
ser salvos no subdiretório *templates/fr_CA*. Depois de ter traduzido todos os
modelos, adicione a localidade à variável `LANGUAGES` no arquivo *Makedefs* e
execute "make install" no subdiretório *templates* para testar a tradução.

*Tabela 1: Arquivos de modelo da interface web*

| Nome de arquivo | Propósito |
| --- | --- |
| add-class.tmpl | Esse é o formulário inicial que é mostrado para adicionar uma nova classe de impressora. |
| add-printer.tmpl | Esse é o formulário inicial que é mostrado para adicionar uma nova impressora. |
| admin.tmpl | Essa é a página principal de administração. |
| choose-device.tmpl | Esse é o formulário que mostra a lista de dispositivos disponíveis. |
| choose-make.tmpl | Esse é o formulário que mostra a lista de fabricantes disponíveis. |
| choose-model.tmpl | Esse é o formulário que mostra a lista de modelos/drivers disponíveis. |
| choose-serial.tmpl | Esse é o formulário que permite que o usuário escolha uma porta serial e quaisquer opções. |
| choose-uri.tmpl | Esse é o formulário que permite que o usuário insira a URI de um dispositivo para impressoras de rede. |
| class.tmpl | Esse modelo mostra informações sobre uma única classe. |
| class-added.tmpl | Esse modelo mostra a mensagem "class added". |
| class-confirm.tmpl | Esse é o modelo usado para confirmar a exclusão de uma classe. |
| class-deleted.tmpl | Esse modelo mostra a mensagem "class deleted". |
| class-jobs-header.tmpl | Esse modelo mostra o cabeçalho "jobs" para trabalhos em uma classe. |
| class-modified.tmpl | Esse modelo mostra a mensagem "class modified". |
| classes.tmpl | Esse modelo mostra uma ou mais classes de impressora. |
| classes-header.tmpl | Esse modelo mostra o cabeçalho "showing N of M classes" na lista de classes. |
| command.tmpl | Esse modelo mostra o estado de um trabalho de comando. |
| edit-config.tmpl | Essa é a página do editor do cupsd.conf |
| error.tmpl | Esse modelo exibe uma mensagem de erro genérico. |
| error-op.tmpl | Essa é a página de erro "unknown operation". |
| header.tmpl(.in) | Esse modelo é usado como o cabeçalho padrão em todos os conteúdos dinâmicos. Edite o arquivo *header.tmpl.in* e faça o script configure gerar o arquivo *header.tmpl*. |
| help-header.tmpl | Essa é a parte superior da página de ajuda. |
| help-printable.tmpl | Essa é o cabeçalho da página padrão para a versão imprimível dos arquivos de ajuda. |
| help-trailer.tmpl | Essa é a parte inferior da página de ajuda. |
| job-cancel.tmpl | Esse modelo mostra "job canceled". |
| job-hold.tmpl | Esse modelo mostra "job held". |
| job-move.tmpl | Essa mensagem mostra o formulário de movimento de trabalho. |
| job-moved.tmpl | Esse modelo mostra "job moved". |
| job-release.tmpl | Esse modelo mostra "job released". |
| job-restart.tmpl | Esse modelo mostra "job reprinted". |
| jobs.tmpl | Esse modelo é usado para listar os trabalhos de impressão em um servidor, classe ou impressora. |
| jobs-header.tmpl | Esse modelo mostra o cabeçalho "showing N or M jobs" na lista de trabalhos. |
| list-available-printers.tmpl | Esse modelo mostra uma lista de novas impressoras que foram encontradas. |
| modify-class.tmpl | Esse modelo é usado como o primeiro formulário ao modificar uma classe. |
| modify-printer.tmpl | Esse modelo é usado como o primeiro formulário ao modificar uma impressora. |
| norestart.tmpl | Esse modelo mostra "server not restarted because no changes were made to the configuration". |
| option-boolean.tmpl | Esse modelo é usado para selecionar uma opção booleana de PPD. |
| option-conflict.tmpl | Esse modelo mostra as opções conflitantes. |
| option-header.tmpl | Esse modelo é usado para inciar um grupo de opções de PPD. |
| option-pickmany.tmpl | Esse modelo é usado para selecionar uma opção multivalorada de PPD. |
| option-pickone.tmpl | Esse modelo é usado para selecionar uma opção univalorada de PPD. |
| option-trailer.tmpl | Esse modelo é usado para terminar um grupo de opções de PPD. |
| pager.tmpl | Esse modelo mostra a barra de paginador anterior/seguinte. |
| printer.tmpl | Esse modelo mostra informações sobre uma única impressora. |
| printer-accept.tmpl | Esse modelo mostra "printer now accepting jobs". |
| printer-added.tmpl | Esse modelo mostra "printer added". |
| printer-cancel-jobs.tmpl | Esse modelo mostra "All jobs on printer have been canceled." |
| printer-configured.tmpl | Esse modelo mostra "printer configured". |
| printer-confirm.tmpl | Esse modelo pede que o usuário confirme a exclusão de uma impressora. |
| printer-default.tmpl | Esse modelo mostra "default printer set". |
| printer-deleted.tmpl | Esse modelo mostra "printer deleted". |
| printer-jobs-header.tmpl | Esse modelo mostra o cabeçalho "jobs" para trabalhos em uma impressora. |
| printer-modified.tmpl | Esse modelo mostra "printer modified". |
| printer-reject.tmpl | Esse modelo mostra "printer now rejecting jobs". |
| printer-start.tmpl | Esse modelo mostra "printer started". |
| printer-stop.tmpl | Esse modelo mostra "printer stopped". |
| printers.tmpl | Esse modelo é usado para listar informações sobre uma ou mais impressoras. |
| printers-header.tmpl | Esse modelo mostra o cabeçalho "showing printer N of M" na lista de impressoras. |
| restart.tmpl | Esse modelo mostra "server restarting". |
| search.tmpl | Esse modelo mostra o formulário de pesquisa. |
| set-printer-options-header.tmpl | Esse modelo mostra a primeira parte do formulário de opções de impressoras definidas. |
| set-printer-options-trailer.tmpl | Esse modelo mostra a última parte do formulário de opções de impressoras definidas. |
| test-page.tmpl | Esse modelo mostra "test page printed". |
| trailer.tmpl | Esse modelo é usado como o trailer padrão em todos os conteúdos dinâmicos. |
| users.tmpl | Esse modelo mostra o formulário de usuários permitidos definidos. |

#### Inserindo atributos e valores

Os arquivos de modelo consistem em HTML com substituições variáveis para o nome
dentro de chaves "{name}". Nomes de variáveis geralmente são os nomes de
atributo IPP com o hífen ("-") substituído pelo caractere de sublinhado ("_").
Por exemplo, o atributo `job-printer-uri` é renomeado para `job_printer_uri`.

Chaves ("{" e "}") indicam substituições e o caractere de barra invertida ("\\")
coloca entre aspas. Para inserir qualquer um desses caracteres especiais, pois é
necessário usar o mecanismo HTML `&name;` ou prefixar cada caractere especial
com a barra invertida ("\\").

Você substitui o valor de uma variável usando `{NAME}` no seu arquivo de modelo.
Se a variável estiver indefinida, a string `{NAME}` será emitida como está.

Para substituir uma string vazia se a variável estiver indefinida, use `{?NAME}`.

#### Substituições de array

O número de elementos da matriz pode ser inserido usando `{#NAME}`. Se a matriz
estiver indefinida, então será emitido 0. O elemento de matriz atual (começando
em 1) é inserido com `{#}`.

As matrizes são tratadas usando `{[NAME]` no início de uma seção e `}` no final.
A informação entre o colchete de fechamento ("]") e a chave de fechamento ("}")
é repetida para tantos elementos quanto disponíveis na matriz designada. Por
exemplo, o seguinte modelo exibirá uma lista de cada trabalho na matriz `job_id`:

    <TABLE>
    <TR>
        <TH>Job ID</TH>
        <TH>Destination</TH>
        <TH>Title</TH>
    </TR>
    
    {[job_id]
    <TR>
        <TD>{?job_id}</TD>
        <TD>{?job_printer_name}</TD>
        <TD>{?job_name}</TD>
    </TR>
    }
    </TABLE>

Matrizes podem ser aninhadas, porém todos os elementos dentro das chaves ("{" and
"}") são indexadas usando a matriz mais interna.

#### Testes condicionais

Os modelos também podem testar variáveis em relação a valores específicos e
incluir condicionalmente texto no modelo. O formato é:

    { variable? true : false }
    { variable = value? true : false }
    { variable! value? true : false }
    { variable < value? true : false }
    { variable > value? true : false }

onde *true* é o texto que é incluído se a condição for verdadeira e *false* é o
texto que é incluído se a condição for falsa. Um valor de `#` é substituído com
o número de elemento atual (iniciando com 1). O caractere após o nome da
variável especifica a condição para testar. A tabela 2 mostra as configurações
de teste disponíveis.

*Tabela 2: Condições de substituição de modelo*

| Caractere | Condição |
| --- | --- |
| ? | Verdadeiro se *variable* existir. |
| = | Verdadeiro se *variable* for igual a *value*. |
| ! | Verdadeiro se *variable* não for igual a *value*. |
| < | Verdadeiro se *variable* for menor que *value*. |
| > | Verdadeiro se *variable* for maior que *value*. |

#### O que localizar em um arquivo de modelo

Como o HTML contém marcação (que geralmente não é localizada) e texto (que *é*
localizado), você deve evitar cuidadosamente alterar a marcação, a menos que ela
contenha texto legível por humanos. Os exemplos HTML a seguir mostram como
localizar corretamente os arquivos de modelo:

    <!-- English table heading -->
    <table class="list" summary="Printer List">
    
    <!-- Correctly localized to French; the class attribute is unchanged but summary is localized -->
    <table class="list" summary="Liste des imprimantes">
    
    <!-- English hyperlink -->
    <li><a {SECTION=help?class="active" :}href="/help/">Help</a></li>
    
    <!-- Correctly localized to Danish; the href attribute is unchanged while the link text is localized -->
    <li><a {SECTION=help?class="active" :}href="/help/">Hjælp</a></li>

### Programas CGI

CUPS usa cinco programas CGI para gerenciar as interfaces web dinâmicas:

* `admin.cgi`
* `classes.cgi`
* `help.cgi`
* `jobs.cgi`
* `printers.cgi`

Cada programa CGI aceita variáveis padrão de formulário, como `OP` para executar
a operação, `PRINTER_NAME` para a impressora ou o nome da classe para operar,
`QUERY` para qualquer palavra de pesquisa, `FIRST` para a primeira classe,
trabalho ou impressora para exibir e `ORDER` para controlar a ordem em que as
classes, trabalhos ou impressoras são exibidas.

Além disso, os programas `classes.cgi`, `jobs.cgi` e `printers.cgi` oferecem
suporte a uma variável `WHICH_JOBS` para controlar quais trabalhos são exibidos.
A tabela 3 lista os valores aos quais há suporte.

*Tabela 3: WHICH_JOBS Valores*

| Valor de WHICH_JOBS | Descrição |
| --- | --- |
| all | Mostra todos os trabalhos |
| completed | Mostra trabalhos finalizados |
| not-completed | Mostra trabalhos ativos |

#### admin.cgi

O programa `admin.cgi` lida com todas as funções de administração de impressora e
classe e é executado para todos os acessos diretos ao recurso */admin*. Para a
maioria das operações, ele usa as variáveis de formulário `PRINTER_NAME` e `OP`
para especificar a ação solicitada. A tabela 4 mostra os valores aos quais `OP`
possui suporte.

*Table 4: Valores de OP do admin.cgi*

| Valor de OP | Descrição |
| --- | --- |
| add-class | Adiciona uma nova classe de impressora |
| add-printer | Adiciona uma nova impressora. |
| config-server | Configura o servidor. |
| delete-class | Exclui uma classe de impressora. A variável de formulário `CONFIRM` pode ser configurada para qualquer valor para ignorar a página de confirmação. |
| delete-printer | Exclui uma impressora. A variável de formulário `CONFIRM` pode ser configurada para qualquer valor para ignorar a página de confirmação. |
| find-new-printers | Localiza novas impressoras que ainda não foram adicionadas. |
| modify-class | Modifica uma classe de impressora. |
| modify-printer | Modifica uma impressora. |
| redirect | Redireciona o navegador web para a localização referenciada pela variável de formulário URL. |
| set-allowed-users | Define os usuários permitidos para um destino. |
| set-as-default | Define o destino padrão. |
| set-printer-options | Define as opções padrões para uma impressora. |
| set-sharing | Define o atributo printer-is-shared para um destino. |

#### classes.cgi

O programa `classes.cgi` é responsável pela listagem de informações de classe,
incluindo trabalhos destinados a essa classe. É para todos os acessos diretos ao
recurso */classes* e oferece suporte às variáveis de formulário opcionais `OP` e
`WHICH_JOBS`. Se nenhuma variável de formulário for fornecida, o CGI listará
todas ou uma classe específica e os trabalhos ativos em cada classe. A tabela 5
mostra os valores aos quais `OP` possui suporte.

*Table 5: Valores de OP do classes.cgi*

| Valor de OP | Descrição |
| --- | --- |
| accept-jobs | Começa a aceitar trabalhos de uma classe. |
| cancel-jobs | Cancela todos os trabalhos de uma classe. |
| move-jobs | Move todos os trabalhos para um destino diferente. |
| print-test-page | Imprime uma página de teste do PostScript. |
| reject-jobs | Para de aceitar trabalhos de uma classe. |
| start-class | Começa a processar trabalhos de uma classe. |
| stop-class | Para de processar trabalhos de uma classe. |

#### help.cgi

O programa `help.cgi` lida com todas as funções de ajuda on-line e é executado
para todos os acessos diretos ao recurso */help*.

#### jobs.cgi

O programa `jobs.cgi` lida com todas as funções do trabalho e é executado para
todos os acessos diretos ao recurso */jobs*. Para a maioria das operações, ele
usa as variáveis de formulário `JOB_ID`, `OP` e `WHICH_JOBS` para especificar a
ação solicitada. A tabela 6 mostra os valores aos quais `OP` possui suporte.

*Tabela 6: Valores de OP do jobs.cgi*

| Valor de OP | Descrição |
| --- | --- |
| cancel-job | Cancela um trabalho. |
| hold-job | Retém um trabalho indefinidamente. |
| move-job | Move um trabalho para outro destino. |
| release-job | Libera um trabalho para impressão. |
| restart-job | Reinicia/reimprime um trabalho de impressão parado, cancelado, finalizado ou abortado. |

#### printers.cgi

O programa `printers.cgi` é responsável pela listagem de informações de
impressora, incluindo trabalhos destinados a essa impressora. Ele serve para
todos os acessos diretos ao recurso */printers* e oferece suporte às variáveis
de formulário opcionais `OP` e `WHICH_JOBS`. Se nenhuma variável de formulário
for fornecida, o CGI listará todas as impressoras ou uma impressora específica e
os trabalhos ativos naquela impressora. A tabela 7 mostra os valores aos quais
`OP` possui suporte.

*Tabela 7: Valores de OP do printers.cgi*

| Valor de OP | Descrição |
| --- | --- |
| accept-jobs | Começa a aceitar trabalhos para uma impressora. |
| cancel-jobs | Cancela todos os trabalhos de uma impressora. |
| clean-print-heads | Limpa as cabeças de impressão. |
| move-jobs | Move todos os trabalhos para um destino diferente. |
| print-self-test-page | Imprime a página de autoteste de uma impressora. |
| print-test-page | Imprime uma página de teste do PostScript. |
| reject-jobs | Para de aceitar trabalhos para uma impressora. |
| start-printer | Começa a processar trabalhos de uma impressora. |
| stop-printer | Para de processar trabalhos de uma impressora. |
