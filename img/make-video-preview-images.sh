#!/bin/bash

base_url='https://img.youtube.com/vi/'
url_postfix='/mqdefault.jpg'
# For YouTube Image Thumbnail URLs see http://promincproductions.com/blog/youtube-image-thumbnail-urls/


PLAYLIST_ID=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM

# Get video ids using YouTube API
video_ids=$(curl "https://www.googleapis.com/youtube/v3/playlistItems?part=id%2CcontentDetails&maxResults=20&playlistId=$PLAYLIST_ID&key=$KEY" \
	--header 'Accept: application/json' --compressed | jq -r '.items[].contentDetails.videoId')
video_ids=($video_ids)

 # Fetch the thumbnails
for video_id in "${video_ids[@]}"
do
	curl $base_url$video_id$url_postfix -o $video_id.jpg
done

# Overlay play button icon on the thumbnails
for pic in *.jpg; do
	echo $pic
    composite -gravity Center -quality 100 64px-YouTube_play_buttom_icon_\(2013-2017\).svg.png $pic $pic
done
