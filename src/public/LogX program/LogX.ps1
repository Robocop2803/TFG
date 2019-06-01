do{
$postParams = @{email=(Read-Host "Email");password=(Read-Host "password")}
$i = Invoke-WebRequest -Uri http://localhost:3000/users/signin -Method POST -Body $postParams -SessionVariable myWebSession
$login_check=(Invoke-WebRequest -Uri http://localhost:3000/login-check -WebSession $myWebSession).content -eq "ok"
}until($login_check)
$user = $postParams.email
if(!(Test-Path .\data\machine-data.txt)){
do{
$name = read-host "name"
Connect-Mdbc . logxdb ordenadors
$query = New-MdbcQuery -and ((New-MdbcQuery -Name user -eq $user),(New-MdbcQuery -Name name -eq $name))
$check = (Get-MdbcData -Query $query).count -eq 0
}until($check)
$adsObjects = New-Object System.Collections.ArrayList
$object = New-Object System.Object
$object | Add-Member -type NoteProperty –Name name      –Value    $name
$object | Add-Member -type NoteProperty –Name os      –Value    "Windowa 10"
$object | Add-Member -type NoteProperty –Name user     –Value    $user
$object | Add-Member -type NoteProperty –Name last_update     –Value    (Get-Date -Format yyyyMMddHHmmss)
$adsObjects.Add($object)
Connect-Mdbc . logxdb ordenadors
$adsObjects | Add-MdbcData
$query_id = New-MdbcQuery -and ((New-MdbcQuery -Name name -eq $name),(New-MdbcQuery -Name user -eq $user))
"Name,Value"> .\data\machine-data.txt
(Get-MdbcData -Query $query_id | select values | Out-String).split(",").replace("{","*id,").split("*")[1] >> .\data\machine-data.txt
}else{
#start subprocesos???
}
