# Ruta al archivo de salida
$archivoSalida = "Appx2Delete.lst"

# Obtener todas las aplicaciones Windows preinstaladas
$apps = Get-AppxPackage | Where-Object { $_.IsFramework -eq $false }

# Escribir los nombres de las aplicaciones en el archivo de salida
$apps | ForEach-Object {
    "# " + $_.Name | Out-File -Append -FilePath $archivoSalida
}

Write-Host "Se han escrito los nombres de las aplicaciones en el archivo $archivoSalida"
