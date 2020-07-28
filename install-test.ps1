#retrieve sn-mid-name & sn-instance from .env file
$mid= Get-Content -Path .\.env | Where-Object {$_ like '*SN_MID_NAME=*'}
$midname=$mid -replace ".*="
$instance= Get-Content -Path .\.env | Where-Object {$_ -like '*SN_INSTANCE=*'}
$instancename=$instance -replace ".*="

#service test vars
$ServiceName = 'ServiceNow MID Server ' + $midname
$arrService = Get-Service -Name $ServiceName
#mid connection vars
$Server = $instancename + ".service-now.com"
#mid-log lock vars
$Wantfile = "/ServiceNow/"+$midname+"/agent/logs/agent0.log.0.lck"
$FileExists =Test-Path $Wantfile

function service-test
{
        If ($arrService.Status -eq 'Running')
        {
                Write-Host 'True: Service is running'
        }
        Else
        {
                Write-Host 'False: Service is not running. check mid server service'
        }
}
function connection-test
{
        If(Test-connection $Server -Count 1 -Quiet){
        $status='True'
        Write-Host True: $Server is pingable
        }
        Else {$status='False'
        Write-Host False: $Server is offline. check connectivity
        }
}
function loglck-test
{
        If ($FileExists -eq $True) {Write-Host "True: agent0.log.0.lck file present, mid server running on host"}
        Else {Write-Host "False: agent0.log.0.lck file not present. check mid server service"}
}
function install-tests
{
        service-test
        connection-test
        loglck-test
}       
