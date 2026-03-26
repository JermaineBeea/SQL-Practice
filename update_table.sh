# PATH - /bin/bash

table="$1"
tableFile="${table}.txt"

sqlite3 mainDataBase.db << EOF
.headers on
.mode column
.output $tableFile
SELECT * FROM $table;
EOF