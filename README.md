# Running locally
```sh
# If you have a .env setup with AWS_{ACCESS,SECRET}_KEY
eval export $(cat .env)
# Use nix to fetch necessary utilities.
nix shell
# Archive today
bash archive_date.sh
# OR archive specific date
bash archive_date.sh $ARCHIVE_DATE
```
