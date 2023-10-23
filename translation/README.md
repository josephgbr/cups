# Tradução do guia do tradutor do CUPS

Esta é uma tradução não-oficial do guia do tradutor do CUPS, visando facilitar a leitura para interessados. A versão oficial, em inglês, encontra-se em https://www.cups.org/doc/translation.html

### Procedimentos para gerar e atualizar este guia:

*Atenção: os procedimentos abaixo precisam do [translate-toolkit](http://toolkit.translatehouse.org/).*

1. Tenha instalado os pacotes gettext (binários msgmerge e msgfmt), sed, curl e python 3.x.

2. Instale pacotes python
```
pip install mdpo html2text
```

3. Execute `./updatepo.sh`

4. Traduza/Atualize a tradução do arquivo `translation.po` usando seu editor de arquivo PO favorito.

5. Após terminar a tradução, converta o catálogo de mensagens em HTML traduzido usando:
```
po2md translation-en.md -p translation.po -s ../guia-de-traducao.md --check
```
