#!/bin/bash

table="$1"                  # Table name passed as argument
tableFile="${table}.txt"    # Output file based on table name

sqlite3 mainDataBase.db <<EOF
.headers on
.mode column
.output $tableFile
SELECT * FROM $table;
EOF