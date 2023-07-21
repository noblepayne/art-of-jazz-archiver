#!/usr/bin/env bash
TODAY=$(date +%F)
ARCHIVE_DATE=${1:-$TODAY}
BASEDIR=$(pwd)

echo
echo "RUNNING FOR ${ARCHIVE_DATE}"
echo


mkdir -p "workdir/${ARCHIVE_DATE}"
cd "workdir/${ARCHIVE_DATE}" || exit 1

{
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T14-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T15-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T16-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T17-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T18-00-00.m4a"
} >> files_to_download.txt

aria2c -i files_to_download.txt
rm files_to_download.txt

echo

download_count=$(find . -maxdepth 1 -type f | wc -l)
if [ "$download_count" -ne 5 ]; then
    {
      echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T14-00-01.m4a"
      echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T15-00-01.m4a"
      echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T16-00-01.m4a"
      echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T17-00-01.m4a"
      echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T18-00-01.m4a"
    } >> files_to_download.txt
    aria2c -i files_to_download.txt
    rm files_to_download.txt
fi

echo

download_count=$(find . -maxdepth 1 -type f | wc -l)
if [ "$download_count" -eq 5 ]; then
    echo "DOWNLOAD COMPLETE"
else
    echo "!!!!!!!!!!!!!!!!! DOWNLOAD INCOMPLETE !!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi

echo

cd "$BASEDIR" || exit 1

rclone --config rclone.conf copyto --progress ./workdir/ DO:artofjazz/episodes/
