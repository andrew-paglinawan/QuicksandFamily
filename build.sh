#!/bin/sh

# -------------------------------------------------------------------
# UPDATE THIS VARIABLE ----------------------------------------------

# thisFont="Quicksand" # must match the name in the font file, e.g. FiraCode-VF.ttf needs the variable "FiraCode"

# -------------------------------------------------------------------
# Update the following as needed ------------------------------------
set -e
# source venv/bin/activate
# echo "I should have activated a virtual environment now"


echo "creating variable directory in fonts"

mkdir -p ./fonts/variable

echo "Made variable font directory"

echo "Making Quicksand-VF.ttf"

fontmake -o variable -g ./sources/Quicksand.glyphs --output-dir ./fonts/variable/ --verbose ERROR 

echo "Made Quicksand-VF.ttf"

echo "Removing Build UFOS"

rm -rf master_ufo/ instance_ufo/

echo "Build UFOS Removed"

echo "fix nonhinting script"
# ##add the fixes that we know are necessary from initial fontbakery run
gftools fix-nonhinting ./fonts/variable/Quicksand-VF.ttf ./fonts/variable/Quicksand-VF.ttf.fix
rm -rf ./fonts/variable/Quicksand-VF-backup-fonttools-prep-gasp.ttf
rm -rf ./fonts/variable/Quicksand-VF.ttf
mv ./fonts/variable/Quicksand-VF.ttf.fix ./fonts/variable/Quicksand-VF.ttf
echo "fix nonhinting script complete"



echo "fix DSIG script Running"
gftools fix-dsig --autofix ./fonts/variable/Quicksand-VF.ttf
echo "fix DSIG script Complete"

echo "OS/2 table patch begin"
# copies the 'OS/2' table patch into the variable outputs folder
cp ./patch/Quicksand-VF.ttx ./fonts/variable/Quicksand-VF.ttx
#walkin' down to the variable level
cd fonts/variable/
#mergin' in my patched os2 
ttx -m Quicksand-VF.ttf Quicksand-VF.ttx
#Deletin' that nasty wrong file
rm -rf Quicksand-VF.ttf
rm -rf Quicksand-VF.ttx
#rename that new guy the gorrect name
mv Quicksand-VF#1.ttf Quicksand-Roman-VF.ttf
