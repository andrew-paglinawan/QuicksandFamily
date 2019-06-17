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


###############################################################
fontbakery check-googlefonts Quicksand-Roman-VF.ttf  
###############################################################

# echo "Generating VFs"
# # mkdir -p ./fonts/variable
# fontmake -g sources/Karla-Roman.glyphs -o variable --output-path ./fonts/variable/Karla-Roman-VF.ttf
# fontmake -g sources/Karla-Italic.glyphs -o variable --output-path ./fonts/variable/Karla-Italic-VF.ttf

# echo "Removing Build UFOS"

# rm -rf master_ufo/ instance_ufo/

# echo "Build UFOS Removed"

# echo "Post processing"

# ttfs=$(ls fonts/ttf/*.ttf)
# echo $ttfs
# for ttf in $ttfs
# do
# 	gftools fix-dsig -f $ttf;
# 	gftools fix-nonhinting $ttf "$ttf.fix";
# 	mv "$ttf.fix" $ttf;
# done
# echo "fixed nonhinting ttfs as well as DSIG"

# rm ./fonts/ttf/*backup*.ttf

# vfs=$(ls ./fonts/variable/*.ttf)
# for vf in $vfs
# do
# 	gftools fix-dsig -f $vf;
# 	gftools fix-nonhinting $vf "$vf.fix";
# 	mv "$vf.fix" $vf;
# 	ttx -f -x "MVAR" $vf; # Drop MVAR. Table has issue in DW
# 	rtrip=$(basename -s .ttf $vf)
# 	new_file=./fonts/variable/$rtrip.ttx;
# 	rm $vf;
# 	ttx $new_file
# 	rm ./fonts/variable/*.ttx
# done
# rm ./fonts/variable/*backup*.ttf

# echo "fix vf meta? ok let's try that. I'm trying to fix VF meta"
# gftools fix-vf-meta $vfs;
# for vf in $vfs
# do
# 	mv "$vf.fix" $vf;
# done

# echo "Post processing complete"



# cp /Users/mirkovelimirovic/Documents/GitHub/Karla/fonts/OFL.txt /Users/mirkovelimirovic/Documents/GitHub/Karla/fonts/ttf/OFL.txt
# cp /Users/mirkovelimirovic/Documents/GitHub/Karla/fonts/OFL.txt /Users/mirkovelimirovic/Documents/GitHub/Karla/fonts/variable/OFL.txt

# # echo "fixing name-ids"
# # gftools fix-nameids $vfs;
# # for vf in $vfs 
# # do 
# # 	mv "$vf.fix" $vf;
# # done

# # echo "fixed name-ids"
# # # cd ..

# # # # ============================================================================
# # # # Autohinting ================================================================

# # statics=$(ls ./fonts/ttf/*.ttf)
# # echo hello
# # for file in $statics; do 
# #     echo "fix DSIG in " ${file}
# #     gftools fix-dsig --autofix ${file}


# #     echo "TTFautohint " ${file}
# #     # autohint with detailed info
# #     hintedFile=${file/".ttf"/"-hinted.ttf"}
# #     ttfautohint -I ${file} ${hintedFile} 
# #     cp ${hintedFile} ${file}
# #     rm -rf ${hintedFile}
# # done

# # # # ============================================================================
# # # # Fix Hinting ================================================================

# # statics=$(ls ./fonts/ttf/*.ttf)
# # echo "Hi Mirko I am trying to fix the hinting in the statics"
# # for file in $statics; do 
# # 	echo "fix hinting in " ${file}
# # 	# fix hinting 
# #     gftools fix-hinting ${file} 
# #  done

# #   ###Remove Broken ttfs ###
# # 	echo "rm rfing ttfs"
# # 	rm -rf fonts/ttf/*.ttf
# # 	echo "ttfs removed"


# #   # Rename all *.ttf.fix to *.ttf                                                                 
# # for f in ./fonts/ttf/*.ttf.fix; do 
# #     mv -- "$f" "${f%.ttf.fix}.ttf"     
# # done



# # # Build woff2 fonts ==========================================================

# # # requires https://github.com/bramstein/homebrew-webfonttools

# # rm -rf fonts/woff2

# # ttfs=$(ls ./fonts/*/*.ttf)
# # for ttf in $ttfs; do
# #     woff2_compress $ttf
# # done

# # mkdir -p fonts/woff2
# # woff2s=$(ls ./fonts/*/*.woff2)
# # for woff2 in $woff2s; do
# #     mv $woff2 fonts/woff2/$(basename $woff2)
# # done
# # # # ============================================================================
# # # # Build woff fonts ==========================================================

# # # # requires https://github.com/bramstein/homebrew-webfonttools

# # # rm -rf fonts/woff

# # ttfs=$(ls ./fonts/*/*.ttf)
# # for ttf in $ttfs; do
# #     sfnt2woff-zopfli $ttf
# # done

# # mkdir -p fonts/woff
# # woffs=$(ls ./fonts/*/*.woff)
# # for woff in $woffs; do
# #     mv $woff fonts/woff/$(basename $woff)
# # done