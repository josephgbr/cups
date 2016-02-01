#!/bin/bash
#
#   unicode2html - fix characters with accentuation in HTML files
#   Copyright (C) 2016 Rafael Fontenelle
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Note to myself: http://erikasarti.net/html/acentuacao-caracteres-especiais/

infile=$1

#bkpfile="$infile~"
#cp -a $infile $bkpfile

if [ ! -r $infile ]; then
  echo "Failed reading the HTML file. Exiting..."
  exit 1
fi

if [ ! -w $infile ]; then
  echo "HTML file $infile is not writable. Exiting..."
  exit 1
fi

echo -n "Converting $infile ... "

# letter a
sed -i 's/á/\&aacute;/g' $infile
sed -i 's/Á/\&Aacute;/g' $infile
sed -i 's/ã/\&atilde;/g' $infile
sed -i 's/Ã/\&Atilde;/g' $infile
sed -i 's/â/\&acirc;/g' $infile
sed -i 's/Â/\&Acirc;/g' $infile
sed -i 's/à/\&agrave;/g' $infile
sed -i 's/À/\&Agrave;/g' $infile
# letter e
sed -i 's/é/\&eacute;/g' $infile
sed -i 's/É/\&Eacute;/g' $infile
sed -i 's/ê/\&ecirc;/g' $infile
sed -i 's/Ê/\&Ecirc;/g' $infile
# letter i
sed -i 's/í/\&iacute;/g' $infile
sed -i 's/Í/\&Iacute;/g' $infile
# letter o
sed -i 's/ó/\&oacute;/g' $infile
sed -i 's/Ó/\&Oacute;/g' $infile
sed -i 's/õ/\&otilde;/g' $infile
sed -i 's/Õ/\&Otilde;/g' $infile
sed -i 's/ô/\&ocirc;/g' $infile
sed -i 's/Ô/\&Ocirc;/g' $infile
# letter u
sed -i 's/ú/\&uacute;/g' $infile
sed -i 's/Ú/\&Uacute;/g' $infile
# letra c-cedilha
sed -i 's/ç/\&ccedil;/g' $infile
sed -i 's/Ç/\&Ccedil;/g' $infile

echo "done"