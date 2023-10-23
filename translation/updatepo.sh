#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# 1. Download translation guide webpage
curl -s -o translation.html https://www.cups.org/doc/translation.html

# 2. Patch HTML file to fix issues (read the patch file for more info)
git apply html.patch

# 4. Convert from HTML to Markdown file
html2text --body-width=0 translation.html > translation-en.md

# 5. Patch Markdown file so a '>' char does not quote the text
sed -i '/True if _variable_ is greater than _value_./s/^>/\\>/' translation-en.md

# 6. Patch Markdown file because code-block text won't show up as italic.
sed -i translation-en.md \
    -e '/{ _variable_/s/_true_/true/' \
    -e '/{ _variable_/s/_false_/false/' \
    -e '/{ _variable_/s/_value_/value/' \
    -e '/{ _variable_/s/_variable_/variable/'

# 4. Extract source strings from Markdown file to PO file
md2po -P translation-en.md --po-encoding UTF-8 --check > translation.pot

# 5. Update translations in the existing file
msgmerge -U --backup=off --previous -l pt_BR -q translation.po translation.pot
msgfmt -cvo /dev/null translation.po
