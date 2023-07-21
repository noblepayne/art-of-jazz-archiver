# Running locally
```sh
# If you have a .env setup with AWS_{ACCESS,SECRET}_KEY
eval export $(cat .env)
# Use nix to fetch necessary utilities.
nix shell
# Archive today
archive
# OR archive specific date
archive $ARCHIVE_DATE
```
