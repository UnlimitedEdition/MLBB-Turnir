$folder = "E:\MLBB-Turnir"
$csvPath = "$folder\prijave.csv"
$htmlPath = "$folder\prijava.html"

if(-not (Test-Path $csvPath)) {
    "ImeTima,Clanovi,Kontakt,Datum" | Out-File $csvPath -Encoding UTF8
}

$prijave = Import-Csv $csvPath
$htmlTable = $prijave | ConvertTo-Html -Fragment

$template = @"
<!DOCTYPE html>
<html>
<head>
    <title>Prijave Timova</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Prijavljeni Timovi</h2>
        $htmlTable
    </div>
</body>
</html>
"@

$template | Set-Content $htmlPath
