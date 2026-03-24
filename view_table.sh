#!/bin/bash

displayTable="$1"

if [ -z "$displayTable" ]; then
  echo "Usage: $0 <table_name>"
  exit 1
fi

# Check table exists before querying
tableExists=$(sqlite3 mainDataBase.db "SELECT name FROM sqlite_master WHERE type='table' AND name='$displayTable';")

if [ -z "$tableExists" ]; then
  echo "Error: Table '$displayTable' does not exist in database.db"
  exit 1
fi

sqlite3 mainDataBase.db \
  -cmd ".headers on" \
  -cmd ".mode column" \
  "SELECT * FROM $displayTable;"