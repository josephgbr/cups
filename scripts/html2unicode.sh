#!/bin/bash
#
#   html2unicode - convert chars with accentuation from HTML format to unicode compatible
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
sed -i 's/\&aacute;/á/g' $infile
sed -i 's/\&Aacute;/Á/g' $infile
sed -i 's/\&atilde;/ã/g' $infile
sed -i 's/\&Atilde;/Ã/g' $infile
sed -i 's/\&acirc;/â/g'  $infile
sed -i 's/\&Acirc;/Â/g'  $infile
sed -i 's/\&agrave;/à/g' $infile
sed -i 's/\&Agrave;/À/g' $infile
# letter e
sed -i 's/\&eacute;/é/g' $infile
sed -i 's/\&Eacute;/É/g' $infile
sed -i 's/\&ecirc;/ê/g'  $infile
sed -i 's/\&Ecirc;/Ê/g'  $infile
# letter i
sed -i 's/\&iacute;/í/g' $infile
sed -i 's/\&Iacute;/Í/g' $infile
# letter o
sed -i 's/\&oacute;/ó/g' $infile
sed -i 's/\&Oacute;/Ó/g' $infile
sed -i 's/\&otilde;/õ/g' $infile
sed -i 's/\&Otilde;/Õ/g' $infile
sed -i 's/\&ocirc;/ô/g'  $infile
sed -i 's/\&Ocirc;/Ô/g'  $infile
# letter u
sed -i 's/\&uacute;/ú/g' $infile
sed -i 's/\&Uacute;/Ú/g' $infile
# letra c-cedilha
sed -i 's/\&ccedil;/ç/g' $infile
sed -i 's/\&Ccedil;/Ç/g' $infile

echo "done"