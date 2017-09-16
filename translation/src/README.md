# Tradução do guia do tradutor do CUPS

Esta é uma tradução extraoficial do guia do tradutor do CUPS, visando facilitar a leitura para interessados. A versão oficial, em inglês, encontra-se em https://www.cups.org/doc/translation.html

### Procedimentos para gerar e atualizar este guia:

*Atenção: os procedimentos abaixo precisam do [translate-toolkit](http://toolkit.translatehouse.org/).*

1. Baixe o guia oficial de https://www.cups.org/doc/translation.html

2. Extraia as mensagens do guia para um modelo de catálogo de mensagens (.pot) Gettext:
```
html2po --input="Translating and Customizing CUPS.html" --pot --output=translation.pot
```
3. Crie/Atualize o catálogo de mensagens (.po):

 3.1. Caso o catálodo de mensagens (.po) não exista, crie-o usando:
```
 msginit --locale=pt_BR --input=translation.pot --output=translation.po
```
 3.2. Caso o catálogo de mensagens já exista, atualize-o usando:
```
 msgmerge --previous --lang=pt_BR translation.po translation.pot > temp
 mv temp translation.po
```
4. Traduza/Atualize a tradução do arquivo `translation.po` usando seu editor de arquivo PO favorito.
5. Após terminar a tradução, converta o catálogo de mensagens em HTML traduzido usando:
```
 po2html --template="Translating and Customizing CUPS.html" --input=translation.po --output=translation.html
```
6. Opcionalmente, pode-se criar uma versão markdown a partir do HTML traduzido, para melhor visualização no GitHub. Para isto, [html2text](http://alir3z4.github.io/html2text/) pode ser usado:
```
 html2text translation.html > translation.md
```
7. Coloque translation.md no diretório anterior (`translation/`) como README.md

*Atenção: Há possibilidade de ocorrerem erros de formatação nas conversões entre HTML e PO, mas que podem ser corrigidos manualmente comparando o original com o traduzido.*
