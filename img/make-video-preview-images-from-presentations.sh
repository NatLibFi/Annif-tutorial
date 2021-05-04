#!/bin/bash


 # Fetch the thumbnails
for pdffile in ../presentations/*.pdf
do
	echo $pdffile
	qpdf $pdffile  --pages $pdffile 1 -- tmp.pdf
	pdftoppm tmp.pdf "${pdffile%.*}" -png
done

mv ../presentations/*.png .

# Overlay play button icon on the thumbnails
for pngfile in *-1.png; do
	echo $pngfile
    composite -gravity Center -quality 100 200px-YouTube_play_buttom_icon_\(2013-2017\).svg.png $pngfile $pngfile
	convert -border 4 -bordercolor black -resize 30% $pngfile $pngfile
	#convert -border 20 -bordercolor black -resize 50% $pngfile $pngfile
done
