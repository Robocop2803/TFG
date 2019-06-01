for(){
$query_id = New-MdbcQuery -and ((New-MdbcQuery -Name id -eq $device))
Connect-Mdbc . logxdb tasks
Get-MdbcData -Query $query_id |%{
$type = $_.type
$values = $_.values
$id = $_._id
switch ($type)
{
    'killps' {
        kill $values
        Remove-MdbcData (New-MdbcQuery -Name _id -EQ $id)
    }
    'infops' {
    ps -id $values | select *
    Remove-MdbcData (New-MdbcQuery -Name _id -EQ $id)}
    Default {}
}
}
sleep -Seconds 4
}