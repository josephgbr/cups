# Tradução do guia do tradutor do CUPS

Esta é uma tradução extraoficial do guia do tradutor do CUPS, visando facilitar a leitura para interessados. A versão oficial, em inglês, encontra-se em https://www.cups.org/doc/translation.html

### Procedimentos para gerar e atualizar este guia:

*Atenção: os procedimentos abaixo precisam do [translate-toolkit](http://toolkit.translatehouse.org/).*

1. Baixe o guia oficial de https://www.cups.org/doc/translation.html

2. Converta o HTML para texto Markdown usando [html2text](http://alir3z4.github.io/html2text/):
```
html2text --body-width=0 "Translating and Customizing CUPS.html" > translation-en.md
```
2. Extraia as mensagens do guia para um modelo de catálogo de mensagens (.pot) Gettext:
```
txt2po --input=translation-en.md --pot --output=translation.pot
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
po2txt --template=translation-en.md --input=translation.po --output=translation.md
```
7. Coloque translation.md no diretório anterior (`translation/`) como README.md
