#!/bin/bash

displayTable="$1"

if [ -z "$displayTable" ]; then
  echo "Usage: $0 <table_name>"
  exit 1
fi

sqlite3 mainDataBase.db << EOF
.headers on
.mode column
SELECT * FROM $displayTable;
EOF