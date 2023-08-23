# Ruta al archivo de nombres de paquetes
$packagesFilePath = ".\Appx2Delete.lst"

$ErrorLog = @()

# Verificar si se ejecuta como administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "Ejecuta este script como administrador."
    exit
}

# Crear la carpeta de respaldo si no existe
$logFolder = Join-Path -Path $PSScriptRoot -ChildPath "AppxDelete-log"
if (-not (Test-Path -Path $logFolder)) {
    New-Item -Path $logFolder -ItemType Directory | Out-Null
}

# Inicializar el archivo de registro
$logFile = "$logFolder\UninstallLog.txt"
$null | Out-File -FilePath $logFile

# Leer los nombres de los paquetes desde el archivo y desinstalar
Get-Content $packagesFilePath | ForEach-Object {
    $package = $_.Trim()
    if (-not ($package -match '^#') -and -not [string]::IsNullOrWhiteSpace($package)) {
        $packageFullName = (Get-AppxPackage $package).PackageFullName
        #$backupFileName = "$logFolder\$($packageFullName).appxbundle"

        try {
            # Respaldar el paquete
            #Export-AppxPackage -Package $package -Path $backupFileName -ErrorAction Stop

            # Desinstalar el paquete
            Get-AppxPackage $package | Remove-AppxPackage -ErrorAction Stop
            Write-Output "Desinstalado: $($packageFullName)" | Out-File -Append -FilePath $logFile
        } catch {
            $ErrorLog += $_.Exception.Message
            Write-Output "Error al desinstalar: $($packageFullName)" | Out-File -Append -FilePath $logFile
        }
    }
}

Write-Output "Proceso completado. Los respaldos se encuentran en $logFolder" | Out-File -Append -FilePath $logFile
