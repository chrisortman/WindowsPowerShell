$a = "<style>"
$a = $a + "BODY{background-color:white;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:aqua}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:white}"
$a = $a + "</style>"

function Set-ColumnError
{
    param(
        [Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)][Hashtable] $InputObject,
        [Parameter(Position=1,Mandatory=$true)][string] $Column,
        [Parameter(Position=2,Mandatory=$true)][bool] $Condition
    )

    process {
      
       
        if($Condition) {
            if($InputObject[$Column] -notlike "#error*") {
                $InputObject[$Column] = "#error$($InputObject[$Column])error#"
            }           
        }
        
        return $InputObject
    }
}

$body = Get-PhysicalDisk | 
                        %{ @{ 'FriendlyName' = $_.FriendlyName;
                              'MediaType' = $_.MediaType;
                              'Usage' = $_.Usage;
                              'HealthStatus' = $_.HealthStatus;
                              'OperationalStatus' = $_.OperationalStatus;}} |
                         %{ 
                            #Copy this line for each column you want to add an error condition to
                            #You pass the ColumnName in -Column and then in -Condition you put whatever check
                            #you want (make sure to wrap in parens)
                            #In this example the field will be marked as error if OperationalStatus equals OK
                            Set-ColumnError -InputObject $_ -Column OperationalStatus -Condition ($_.OperationalStatus -eq 'OK') 
                          } |
                         %{ New-Object -TypeName PSObject -Property $_ } |
                         Select-Object FriendlyName, MediaType, Usage, HealthStatus, OperationalStatus |
                         Sort FriendlyName,MediaType |
                         ConvertTo-Html -head $a |
                         Out-String 

$body = $body -replace "#error","<font color='red'>"
$body = $body -replace "error#","</font>"

$messageParameters = @{
    Subject = "Physical Disk Status Report from ISSTORAGE" 
    Body = $body
    From = "ISStorage@innovsys.com"
    To = "chriso@innovsys.com"
    smtpserver = "email.innsys.innovsys.com"
}
send-mailmessage @messageParameters -BodyAsHtml 
