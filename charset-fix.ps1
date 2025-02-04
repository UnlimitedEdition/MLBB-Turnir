$htmlFiles = "index.html", "prijava.html", "rezultati.html", "pravilnik.html"

# Додај мета тагове
foreach ($file in $htmlFiles) {
    $content = Get-Content "E:\MLBB-Turnir\$file" -Raw
    if (-not ($content -match '<meta charset="UTF-8">')) {
        $content = $content -replace '<head>', "<head>`n<meta charset=`"UTF-8`">`n<meta http-equiv=`"Content-Type`" content=`"text/html; charset=UTF-8`">"
        $content | Set-Content "E:\MLBB-Turnir\$file" -Encoding UTF8
    }
}

# Ажурирај стилове
$cssContent = @'
body { font-family: 'Noto Sans', sans-serif; }
@font-face {
    font-family: 'LatinExtended';
    src: url('https://fonts.gstatic.com/s/notosans/v25/o-0OIpQlx3QUlC5A4PNr6ARCQ_k.woff2');
    unicode-range: U+0100-024F;
}
'@
Add-Content -Path "E:\MLBB-Turnir\assets\style.css" -Value $cssContent -Encoding UTF8

# Конвертуј све фајлове у UTF-8 без BOM
Get-ChildItem "E:\MLBB-Turnir\*" -Include *.html, *.css, *.js | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    Set-Content $_.FullName -Value $content -Encoding UTF8 -Force
}