#!/bin/bash
PASSWORD=Ohf5mahkj
HOST=vmtweb04.tsrv.ebuero.de
USER=webtest
DATABASE=d8bsag
DB_FILE=./dump.sql

EXCLUDED_TABLES=(
cache_bootstrap
cache_config
cache_container
cache_content
cache_data
cache_default
cache_discovery
cache_dynamic_page_cache
cache_entity
cache_menu
cache_page
cache_render
cache_rest
cache_toolbar
cachetags
watchdog
)

IGNORED_TABLES_STRING=''
for TABLE in "${EXCLUDED_TABLES[@]}"
do :
   IGNORED_TABLES_STRING+=" --ignore-table=${DATABASE}.${TABLE}"
done

echo "Dump structure"
mysqldump --host=${HOST} --user=${USER} --password=${PASSWORD} --single-transaction --quick --no-data --routines ${DATABASE} > ${DB_FILE}
echo "Done with the structure..."
echo "Dump content"
mysqldump --host=${HOST} --user=${USER} --password=${PASSWORD} ${DATABASE} --no-create-info --skip-triggers --single-transaction --quick ${IGNORED_TABLES_STRING} >> ${DB_FILE}
echo "Done dumping content"
#drop old DB
echo "Drop d8bsag"
mysql -u root -proot -D d8bsag -e "DROP DATABASE IF EXISTS d8bsag;"
echo "Dropped;"
echo "Create new d8bsag"
mysql -u root -proot -e "CREATE DATABASE d8bsag CHARACTER SET utf8"
echo "Created;"
#import new DB
echo "Import sql file"
mysql -u root -proot d8bsag < ${DB_FILE}
echo "Done importing;"
echo "Remove sql file"
rm ${DB_FILE}
echo "File removed;"
echo "Done! :)"