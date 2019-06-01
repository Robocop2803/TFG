

#Eventos disponibles
Get-EventLog -List

#Información sobre log
Get-EventLog Application
Get-EventLog HardwareEvents
Get-EventLog "Internet Explorer"
Get-EventLog Security
Get-EventLog System
Get-EventLog "Windows PowerShell"

#Información sobre IP en los logs
Get-EventLog Application | Where-Object Message -Match "192.168"
Get-EventLog Application | Where-Object Message -Match "192.168" | Select-Object Message
Get-EventLog Application | Where-Object Message -Match "192.168" | Select-Object Message | Format-Custom

#Mostrar logs por fecha
$today = Get-Date
$1day = New-TimeSpan -Days 1
$yesterday = $today - $1day
Get-EventLog -LogName system -EntryType Error, Warning -After $yesterday

#Número de programas instalados (count)
((Get-WmiObject -Class Win32_Product).name).count

#Selecciona el nombre y vendor de los programas instalados
(Get-WmiObject -Class Win32_Product) | Select-Object name,vendor

#Dime la versión de los programas instalados
(Get-WmiObject -Class Win32_Product).version
(Get-WmiObject -Class Win32_Product) | Select-Object name,version

#Dime si está instalado PROGRAMA QUE ELIGAMOS
if(((Get-WmiObject -Class Win32_Product).name) | Select-String "-----"){"Instalado"}

#Listar programas instalados
(Get-WmiObject -Class Win32_Product).name

#Número de programas instalados (count)
((Get-WmiObject -Class Win32_Product).name).count

#Mostrar programas instalados por familia (forma split)
((Get-WmiObject -Class Win32_Product).name) | %{$_.split(' ')[0]}

#Recorrer todos los programas instalados (foreach)
(Get-WmiObject -Class Win32_Product).name | %{$_}

#Indicar si un programa se ha instalado o no (if)
if(((Get-WmiObject -Class Win32_Product).name) | Select-String "VMware"){"Instalado"}

#FUNCION QUE TE DIGA SI HA INSTALADO UN PROGRAMA O NO
function ProgramaInstalado($programa)
{
if(((Get-WmiObject -Class Win32_Product).name) | Select-String $programa){"Instalado"}
}
ProgramaInstalado VMware Player

#¿Qué antivirus utilizamos?
((Get-WmiObject -Class Win32_Product).name) | Select-String 'Antivirus'

#Buscar en el registro información sobre programas
$name='Google'
$producto=(Get-WmiObject -Class Win32_Product)
foreach($uno in $producto)
{
if($uno.name -match $name)
{
$valor=$uno.IdentifyingNumber
$valor=$valor.replace('{','')
$valor=$valor.replace('}','')
}
}
Get-ChildItem hklm:\ -rec -ea SilentlyContinue | % {
if($_ -match $valor){$_}
}

#Listar programas instalados
Get-Package | Select-Object name



####################################################ESPACIO LIBRE DISCO ETC##############################################################
Get-WMIObject Win32_LogicalDisk

Get-WMIObject Win32_LogicalDisk -Filter "DeviceID='E:'"

Get-WMIObject Win32_LogicalDisk -Filter "DeviceID='E:'" | Select-Object FreeSpace,Size

[Double](Get-WMIObject Win32_LogicalDisk -Filter "DeviceID='E:'" | Select-Object FreeSpace).FreeSpace/1GB

[System.Math]::Round((Get-WMIObject Win32_LogicalDisk -Filter "DeviceID='E:'" | Select-Object FreeSpace).FreeSpace/1GB)



####################################################PROCESADOR##############################################################

Get-WmiObject -class "Win32_Processor" | % {
    Write-Host "CPU ID: "
    Write-Host $_.DeviceID
    Write-Host "CPU Model: "
    Write-Host $_.Name
    Write-Host "CPU Cores: "
    Write-Host $_.NumberOfCores
    Write-Host "CPU Max Speed: "
    Write-Host $_.MaxClockSpeed
    Write-Host "CPU Status: "
    Write-Host $_.Status
    Write-Host
}

####################################################SO Y HARDWARE##############################################################

#Sistema operativo instalado sobre una partición
(Get-WmiObject Win32_AutochkSetting).SettingID

#Fabricante de placa base
(Get-WmiObject Win32_BaseBoard).Manufacturer

$consulta="https://www.asus.com/es/Notebooks/" + (Get-WmiObject Win32_BaseBoard).Product
Start-Process chrome $consulta

#Versión de la BIOS
(Get-WmiObject Win32_BIOS).Version

#Buses conectados
(Get-WmiObject Win32_Bus).DeviceID

#Información sobre el procesador
Get-WmiObject Win32_Processor

if((Get-WmiObject Win32_Processor).Caption -match "Intel"){"Intel"}else{"No es Intel"}

#Serial del fabricante que identifica el equipo
Get-WmiObject Win32_SystemEnclosure
(Get-WmiObject Win32_SystemEnclosure).SerialNumber

$tag=(Get-WmiObject Win32_SystemEnclosure).SerialNumber
$consulta="https://www.asus.com/es/Notebooks/"
Start-Process chrome $consulta+$tag

#Estimación del porcentaje de la carga de la batería restante
Get-WmiObject Win32_Battery
(Get-WmiObject Win32_Battery).EstimatedChargeRemaining

$noba=(Get-WmiObject Win32_Battery).Name
$consulta="https://www.asus.com/"
Start-Process chrome $consulta+$noba

#Impresoras en el equipo
Get-WmiObject Win32_Printer

(Get-WmiObject Win32_Printer).name | %{$_ | Out-Printer}

#Almacenar información sobre hardware
(Get-WmiObject Win32_AutochkSetting).SettingID | Out-File inf.txt -Append
(Get-WmiObject Win32_BaseBoard).Manufacturer | Out-File inf.txt -Append
(Get-WmiObject Win32_BIOS).Version | Out-File inf.txt -Append
(Get-WmiObject Win32_Bus).DeviceID | Out-File inf.txt -Append
Get-WmiObject Win32_Processor | Out-File inf.txt -Append
Get-WmiObject Win32_SystemEnclosure | Out-File inf.txt -Append
Get-WmiObject Win32_Battery | Out-File inf.txt -Append
Get-WmiObject Win32_Printer | Out-File inf.txt -Append

#Carpeta sistema operativo con partición
mkdir syst
cd syst
((Get-WmiObject Win32_AutochkSetting).SettingID).split("\")[4] | Out-File syst.txt -WhatIf

#Carpeta placa con fichero de información
mkdir info
cd info
(Get-WmiObject Win32_BaseBoard) | Out-File info.txt -WhatIf