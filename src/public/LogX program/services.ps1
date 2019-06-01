$user= "test@test.com"
$adsObjects = New-Object System.Collections.ArrayList
$device = (cat .\data\machine-data.txt | ConvertFrom-Csv | Where name -EQ id).Value
$object = New-Object System.Object
$id = (Get-Date -Format yyyyMMddHHmmss) + "-services-$user"
$object | Add-Member -type NoteProperty –Name _id      –Value    $id
$object | Add-Member -type NoteProperty –Name date     –Value    (Get-Date -Format yyyyMMddHHmmss)
$object | Add-Member -type NoteProperty –Name user     –Value    $user
$object | Add-Member -type NoteProperty –Name device   –Value    $device
$object | Add-Member -type NoteProperty –Name type     –Value    "services"
$table =  Get-Service | Select-Object -Property Name,DisplayName, @{Name='Status';Expression={" "+$_.Status}}
$object | Add-Member -type NoteProperty –Name content  –Value    $table
$adsObjects.Add($object)
Connect-Mdbc . logxdb lives
#add the objects to the collection
$adsObjects | Add-MdbcData