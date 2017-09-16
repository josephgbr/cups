#!/bin/bash
#
#   gen_tarball.sh - create tarball containing the translation files for CUPS
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

###########################################
# Define initial values of some variables

initialdir=`pwd` # store initial directory before any `cd`
verbose=0  # set initial verbose value

###########################################
# Define some required functions

help() {
    echo -e "Usage: $(basename $0) [options]"
    echo -e "Generate tarball with your translation of CUPS to be sent to the CUPS Dev Team.\n"
    echo -e "Options:\n"
    echo -e "   -i <inputdir>    CUPS source code directory containing all the files,\n" \
            "                      including translated files. (default: current dir)"
    echo -e "   -o <outputfile>  tarball name that will store the translation files.\n"  \
            "                      (default: <locale>.tar.gz)"
    echo -e "   -l <locale>      set locale with a language code, like e.g. pt_BR.\n"   \
            "                      (default: value of \$LANG environment variable)"
    echo -e "   -v               enable verbosity, display more information."
    echo -e "   -h               show help and quit."
    echo -e ""
    echo -e "See source code and report bugs in: https://github.com/rffontenelle/cups-pt_BR"
    exit 2
}

die() {
    echo "Error: $1" > /dev/stderr
    cd "$initialdir"
    exit 1
}

verbose() {
    [[ $verbose -eq 1 ]] && echo "Verbose: $1" 2>&1 
}

###########################################
# Check provided (or not) options, values, directory/file contents

while getopts 'i|o|l|v|h' OPTION; do
    case $OPTION in
        i)  [ ! -z "$OPTARG" ] || die "option -i requires a directory an argument."
            [ -d "$OPTARG" ] || die "unable to find directory containing translated files."
            inputdir=$OPTARG
        ;;
        o)  [ ! -z "$OPTARG" ] || die "option -o requires a filename as an argument."
            outputfile="$OPTARG"
        ;;
        l)  [ ! -z "$OPTARG" ] || die "option -l requires a language code as an argument."
            locale=$OPTARGS
        ;;
        v)  verbose=1
        ;;
        h)  help
        ;;
        *) die "unknown option $OPTION"
        ;;
    esac
done
shift $(($OPTIND - 1))

# are we able to use tar?
tarbin="$(which tar)"
[ -x $tarbin ] || die "unable to find required tar binary."
verbose "using tar binary $tarbin"

# is the inputdir the correct folder? If not provided, try using current folder
if [ -z "$inputdir" ]; then
    inputdir="."
    verbose "input not provided, trying the current dir ($(basename `pwd`))"
fi
[ -d $inputdir/templates ] || die "inputdir \"$inputdir\" invalid: unable to find \"templates\"."
[ -d $inputdir/doc ]       || die "inputdir \"$inputdir\" invalid: unable to find \"doc\"."
[ -d $inputdir/locale ]    || die "inputdir \"$inputdir\" invalid: unable to find \"locale\"."
[ -r $inputdir/desktop/cups.desktop.in ] || die "inputdir \"$inputdir\" invalid: unable to find \"desktop\" file."
if [ "$inputdir" == "." ]; then
    verbose "current dir ($(basename `pwd`)) looks good as inputdir."
else
    verbose "dir \"$inputdir\" looks good as inputdir."
fi

# if locale not set, use system's locale
if [ -z $locale ]; then
   locale=${LANG/.*/}
   [ ! $locale == C ] || die "unable to get locale as it was not provided and \$LANG value is C."
   verbose "using locale $locale from \$LANG."
fi

# use default, if not done already
[ -z "$outputfile" ] && outputfile="$locale.tar.gz"
verbose "using outputfile $outputfile."

cd "$inputdir"

##########################################################
## Verify translation files before adding to sourcefiles
unset sourcefiles

# cups.desktop - was it translated already?
if [ ! "$(grep "\[$locale\]" desktop/cups.desktop.in)" == "" ]; then
    # found locale in desktop.in, e.g. [pt_BR]
    sourcefiles="$sourcefiles desktop/cups.desktop.in"
else
    verbose "no translation for $locale found in desktop/cups.desktop.in. Ignoring."
fi

# doc/ - was it translated already?
if [ -d $inputdir/doc/$locale ]; then
    if [ -r $inputdir/doc/$locale/index.html.in ]; then
        sourcefiles="$sourcefiles doc/$locale/index.html.in"
    else
        verbose "no index.html.in found inside folder $inputdir/doc/$locale. Ignoring."
    fi
else
    verbose "doc folder for locate $locate not found. Ignoring."
fi

# locale (PO file) - was it translated already?
if [ -r locale/cups_$locale.po ]; then
    sourcefiles="$sourcefiles locale/cups_$locale.po"
else
    verbose "no cups_$locale.po found inside folder $inputdir/$locale. Ignoring."
fi

# templates/ - what was translated so far?
if [ -d templates/$locale ]; then
    tmplfiles="$(ls templates/$locale/*.tmpl 2> /dev/null)"
    case $? in
        0) sourcefiles="$sourcefiles $tmplfiles" ;;
        2) verbose "no .tmpl found inside folder $inputdir/templates/$locale. Ignoring." ;;
        *) verbose "templates folder failed for unknown reason. Ignoring." ;;
    esac
else
    verbose "templates folder for locate $locate not found. Ignoring."
fi

###########################################
# Run compression with tar

if [ $verbose -eq 1 ]; then
    taropts="-cvf"
else
    taropts="-cf"
fi

verbose "compressing source files..."
$tarbin $taropts $outputfile $sourcefiles
[ $? -eq 0 ] || die "failure while compressing source files with tar"

# go back to initial directory
cd "$initialdir"
