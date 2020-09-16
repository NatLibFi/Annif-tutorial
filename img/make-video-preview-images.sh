#!/bin/bash

base_url='https://img.youtube.com/vi/'
url_postfix='/mqdefault.jpg'
# For YouTube Image Thumbnail URLs see http://promincproductions.com/blog/youtube-image-thumbnail-urls/

# Insert here the YouTube video IDs to get the preview pictures:
video_ids=(
	'ZKN22mXKMm8'
	'ZKN22mXKMm8'
)
 
for video_id in "${video_ids[@]}"
do
	curl $base_url$video_id$url_postfix -o $video_id.jpg
done


for pic in *.jpg; do
	echo $pic
    composite -gravity Center -quality 100 64px-YouTube_play_buttom_icon_\(2013-2017\).svg.png $pic $pic
done
