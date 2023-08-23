<#
.SYNOPSIS
Este script agrega un carácter "#" al principio de cada línea en un archivo de entrada y guarda las líneas modificadas en un archivo de salida.

.DESCRIPTION
Este script toma un archivo de entrada y un archivo de salida como argumentos. Agrega "#" al principio de cada línea en el archivo de entrada y guarda las líneas modificadas en el archivo de salida.

.PARAMETER archivoEntrada
La ruta al archivo de entrada.

.PARAMETER archivoSalida
La ruta al archivo de salida donde se guardarán las líneas modificadas.

.EXAMPLE
.\NombreDelScript.ps1 -archivoEntrada "ruta\archivo_entrada.txt" -archivoSalida "ruta\archivo_salida.txt"
Ejecuta el script para procesar un archivo de entrada y guardar las líneas modificadas en un archivo de salida.

#>

param (
    [string]$archivoEntrada,
    [string]$archivoSalida
)

# Verificar si el archivo de entrada existe
if (Test-Path -Path $archivoEntrada -PathType Leaf) {
    # Leer el contenido del archivo de entrada línea por línea
    $lineas = Get-Content -Path $archivoEntrada

    # Agregar '#' al principio de cada línea
    $lineasModificadas = $lineas | ForEach-Object { "#$_" }

    # Guardar las líneas modificadas en el archivo de salida
    $lineasModificadas | Out-File -FilePath $archivoSalida -Encoding UTF8

    Write-Host "Archivo modificado guardado en $archivoSalida"
} else {
    Write-Host "El archivo de entrada no existe: $archivoEntrada"
}
