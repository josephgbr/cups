#!/bin/bash
#
#   fix_specialchars - fix characters with accentuation in HTML files
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

###########################################
# Define initial values of some variables

optunicode2html=0
opthtml2unicode=0
optbackup=0
verbose=0

###########################################
# Define some required functions

help() {
    echo -e "Usage: $(basename $0) [options] <inputfile1> [<inputfile2>..<inputfileN>]"
    echo -e "Fix special characters in HTML-like files from/to UTF-8.\n"
    echo -e "Options:\n"
    echo -e "   -f               UTF-8 to HTML-compatible conversion of special chars"
    echo -e "   -t               HTML-compatible to UTF-8 conversion of special chars"
    echo -e "   -b               create a backup file before converting the special chars"
    echo -e "   -v               enable verbosity, display more information."
    echo -e "   -h               show help and quit."
    echo -e ""
    echo -e "See source code and report bugs in: https://github.com/josephgbr/cups-pt_BR"
    exit 2
}

die() {
    echo "Error: $1" > /dev/stderr
    exit 1
}

verbose() {
    [[ $verbose -eq 1 ]] && echo "Verbose: $1" 2>&1 
}

# Sanity check of one inputfile
checkinput() {
    [ -r $inputfile ] || die "failed reading the HTML file."
    [ -w $inputfile ] && die "HTML file $inputfile is not writable."
}

# If requested, created backup of your input file, just for precaution
dobackup() {
    local backupfile=${inputfile}.bkp 
    cp -a $inputfile $backupfile
    [ $? -eq 0 ] || die "failed to create backup file $backupfile."
    verbose "created backup file $backupfile."
}

# This is where conversion is done from UTF-8 to HTML-compatible
unicode2html() {
    local inputfile=$1
    
    [ -x $(which mktemp) ] || die "unable to find mktemp binary, but it is mandatory"
    [ -x $(which iconv) ]  || die "unable to find iconv binary, but it is mandatory"
        
    # if file is iso-8859, convert it in order to make `sed` work
    if [ ! ISO-8859 == *"$(file $inputfile)"* ]; then
        tmp=$(mktemp)
        iconv --from-code=iso-8859-1 --to-code=utf-8 $inputfile > $tmp
        [ $? -eq 0 ] && mv $tmp $inputfile
    fi

    echo -n "Converting $inputfile ... "
    # letter a
    sed -i $inputfile        \
        -e 's/á/\&aacute;/g' \
        -e 's/Á/\&Aacute;/g' \
        -e 's/ã/\&atilde;/g' \
        -e 's/Ã/\&Atilde;/g' \
        -e 's/â/\&acirc;/g'  \
        -e 's/Â/\&Acirc;/g'  \
        -e 's/à/\&agrave;/g' \
        -e 's/À/\&Agrave;/g'
    # letter e
    sed -i $inputfile        \
        -e 's/é/\&eacute;/g' \
        -e 's/É/\&Eacute;/g' \
        -e 's/ê/\&ecirc;/g'  \
        -e 's/Ê/\&Ecirc;/g'
    # letter i
    sed -i $inputfile        \
        -e 's/í/\&iacute;/g' \
        -e 's/Í/\&Iacute;/g'
    # letter o
    sed -i $inputfile        \
        -e 's/ó/\&oacute;/g' \
        -e 's/Ó/\&Oacute;/g' \
        -e 's/õ/\&otilde;/g' \
        -e 's/Õ/\&Otilde;/g' \
        -e 's/ô/\&ocirc;/g'  \
        -e 's/Ô/\&Ocirc;/g'
    # letter u
    sed -i $inputfile        \
        -e 's/ú/\&uacute;/g' \
        -e 's/Ú/\&Uacute;/g'
    # letra c-cedilha
    sed -i $inputfile        \
        -e 's/ç/\&ccedil;/g' \
        -e 's/Ç/\&Ccedil;/g'

    echo "done"
}

# This is where conversion is done from HTML-compatible to UTF-8
html2unicode() {
    local inputfile=$1
    
    echo -n "Converting $inputfile ... "    
    # letter a
    sed -i $inputfile        \
        -e 's/\&aacute;/á/g' \
        -e 's/\&Aacute;/Á/g' \
        -e 's/\&atilde;/ã/g' \
        -e 's/\&Atilde;/Ã/g' \
        -e 's/\&acirc;/â/g'  \
        -e 's/\&Acirc;/Â/g'  \
        -e 's/\&agrave;/à/g' \
        -e 's/\&Agrave;/À/g'
    # letter e
    sed -i $inputfile        \
        -e 's/\&eacute;/é/g' \
        -e 's/\&Eacute;/É/g' \
        -e 's/\&ecirc;/ê/g'  \
        -e 's/\&Ecirc;/Ê/g'
    # letter i
    sed -i $inputfile        \
        -e 's/\&iacute;/í/g' \
        -e 's/\&Iacute;/Í/g'
    # letter o
    sed -i $inputfile        \
        -e 's/\&oacute;/ó/g' \
        -e 's/\&Oacute;/Ó/g' \
        -e 's/\&otilde;/õ/g' \
        -e 's/\&Otilde;/Õ/g' \
        -e 's/\&ocirc;/ô/g'  \
        -e 's/\&Ocirc;/Ô/g'
    # letter u
    sed -i $inputfile        \
        -e 's/\&uacute;/ú/g' \
        -e 's/\&Uacute;/Ú/g'
    # letra c-cedilha
    sed -i $inputfile        \
        -e 's/\&ccedil;/ç/g' \
        -e 's/\&Ccedil;/Ç/g'

    echo "done"
}

####################################
# Here we start executing stuff

while getopts 'f|t|b|v|h' OPTION; do
    case $OPTION in
        ;;
        f)  [ ! -f "$OPTARG" ] || die "option -f requires at least one filename as argument."
            optunicode2html=1
        ;;
        t)  [ ! -z "$OPTARG" ] || die "option -t requires at least one filename as argument."
            opthtml2unicode=1
        ;;
        b)  optbackup=1
        ;;
        v)  verbose=1
        ;;
        h)  help
        ;;
        *) die "unknown option $OPTION."
        ;;
    esac
done
shift $(($OPTIND - 1))

[[ $optunicode2html -eq 1 && $opthtml2unicode -eq 1 ]] || die "options -f and -t are mutually exclusive."
[[ $optunicode2html -eq 0 && $opthtml2unicode -eq 0 ]] || die "you must provide either -f or -t options."

inputitems="$@"
[ ! -z "$inputitems" ] || die "no input files or directory provided"

if [ $optunicode2html -eq 1 ]; then
    for inputfile in $inputitems; do
        checkinput
        [ $optbackup -eq 1 ] && dobackup
        unicode2html $inputfile
    done
elif [ $opthtml2unicode -eq 1 ]; then
    for inputfile in $inputitems; do
        checkinput
        [ $optbackup -eq 1 ] && dobackup
        html2unicode $inputfile
    done
fi
