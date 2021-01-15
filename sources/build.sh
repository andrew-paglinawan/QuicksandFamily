#!/bin/sh

set -e

echo "creating variable directory in fonts"
mkdir -p ../fonts ../fonts/statics


echo "Making Quicksand-VF.ttf"
VF_PATH='../fonts/Quicksand[wght].ttf'

fontmake -o variable -g Quicksand.glyphs --output-path $VF_PATH
rm -rf master_ufo/ instance_ufo/

echo "Post processing"
python -c "from fontTools.ttLib import TTFont;f=TTFont('$VF_PATH');f['OS/2'].usWeightClass=300;f.save('$VF_PATH')"
gftools fix-nonhinting $VF_PATH $VF_PATH
gftools fix-dsig --autofix $VF_PATH
# drop MVAR table.
ttx -x 'MVAR' $VF_PATH
ttx -f '../fonts/Quicksand[wght].ttx'
rm ../fonts/*.ttx ../fonts/*gasp.ttf
