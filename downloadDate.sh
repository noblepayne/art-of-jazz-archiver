# TODAY=$(TZ="America/Los_Angeles" date +%F)
TODAY=$(python3 -c 'import datetime; import zoneinfo; print(datetime.datetime.now(tz=zoneinfo.ZoneInfo("UTC")).astimezone(zoneinfo.ZoneInfo("America/Los_Angeles")).strftime("%F"))')
ARCHIVE_DATE=${1:-$TODAY}
BASEDIR=$(pwd)
WORKDIR=$(mktemp -d)

echo
echo -n "Date currently shows: " && date
echo "ARCHIVE_DATE = ${ARCHIVE_DATE}"
echo


mkdir -p "$WORKDIR/${ARCHIVE_DATE}"
cd "$WORKDIR/${ARCHIVE_DATE}" || exit 1

{
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T14-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T15-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T16-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T17-00-00.m4a"
  echo "https://d3en5yq84nu4pk.cloudfront.net/${ARCHIVE_DATE}/knkx_${ARCHIVE_DATE}T18-00-00.m4a"
} >> files_to_download.txt

aria2c -i files_to_download.txt || true
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
    aria2c -i files_to_download.txt || true
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
echo "$TODAY" >> log.txt
