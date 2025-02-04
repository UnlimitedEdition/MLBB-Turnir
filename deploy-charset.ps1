# Покрени поправке
.\charset-fix.ps1

# Гит операције
Set-Location E:\MLBB-Turnir
git add .
git commit -m "Ажурирана подршка за специјалне знакове"
git push origin main

# Отвори валидатор
Start-Process "https://validator.w3.org/nu/?doc=https%3A%2F%2Funlimitededition.github.io%2FMLBB-Turnir%2F"