$ipaddress = ([System.Net.DNS]::GetHostAddresses($env:COMPUTERNAME) | Where-Object { $_.AddressFamily -eq "InterNetwork" } |  select-object IPAddressToString)[0].IPAddressToString
If ($ipaddress -EQ '192.168.2.1') {
    $ipaddress = (Get-NetIPAddress -InterfaceAlias Ethernet -AddressFamily IPv4 | select-object IPAddress)[0].IPAddress
    $consoleuser = query session | select-string console | foreach { -split $_ } | select -index 1
    $cl = "C:\Users\" + $consoleuser + "\AppData\Roaming\Docker\settings.json"
    $a = Get-Content $cl -raw | ConvertFrom-Json
    $a.ProxyHttp = "http://" + $ipaddress + ":3128"
    $a.ProxyHttps = "http://" + $ipaddress + ":3128"
    $a | ConvertTo-Json | set-content $cl
}
else {
    $consoleuser = query session | select-string console | foreach { -split $_ } | select -index 1
    $cl = "C:\Users\" + $consoleuser + "\AppData\Roaming\Docker\settings.json"
    $a = Get-Content $cl -raw | ConvertFrom-Json
    $a.ProxyHttp = "http://" + $ipaddress + ":3128"
    $a.ProxyHttps = "http://" + $ipaddress + ":3128"
    $a | ConvertTo-Json | set-content $cl
}
