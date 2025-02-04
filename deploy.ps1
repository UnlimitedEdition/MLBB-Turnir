$folder = "E:\MLBB-Turnir"

try {
    # Ажурирање података
    & "$folder\update-prijave.ps1"
    & "$folder\update-rezultati.ps1"
    
    # Git операције
    Set-Location $folder
    git add .
    git commit -m "Automatski update: $(Get-Date -Format 'dd.MM.yyyy HH:mm')"
    git push origin main
    
    Write-Host "Deploy успешан!" -ForegroundColor Green
}
catch {
    Write-Error "Грешка при deploy-у: $_"
}
