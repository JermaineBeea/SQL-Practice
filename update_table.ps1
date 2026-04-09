param (
    [Parameter(Mandatory = $true)]
    [string]$Table
)

$TableFile = "$Table.txt"
$Db = "mainDataBase.db"

sqlite3 $Db `
    -cmd ".headers on" `
    -cmd ".mode column" `
    -cmd ".output $TableFile" `
    "SELECT * FROM $Table;"