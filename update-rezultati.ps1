$folder = "E:\MLBB-Turnir"
$csvPath = "$folder\rezultati.csv"
$htmlPath = "$folder\rezultati.html"

if(-not (Test-Path $csvPath)) {
    "Tim,Damage,Heroji,Tornjevi,Datum" | Out-File $csvPath -Encoding UTF8
}

$rezultati = Import-Csv $csvPath
$rangLista = $rezultati | Group-Object Tim | ForEach-Object {
    [PSCustomObject]@{
        Tim = $_.Name
        UkupanDamage = ($_.Group.Damage | Measure-Object -Sum).Sum
        ProsjekTornjeva = [math]::Round(($_.Group.Tornjevi | Measure-Object -Average).Average, 2)
        BrojMecova = $_.Group.Count
    }
} | Sort-Object UkupanDamage -Descending

$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Rezultati Turnira</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Rang Lista</h2>
        $($rangLista | ConvertTo-Html -Property Tim,UkupanDamage,ProsjekTornjeva,BrojMecova)
    </div>
</body>
</html>
"@

$htmlContent | Set-Content $htmlPath
