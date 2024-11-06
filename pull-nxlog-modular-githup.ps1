[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/NxLog-Globalconfig.conf" -Outfile C:\Windows\Temp\master.conf

Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/nxlog-WindEvent-SecOps.conf" -Outfile C:\Windows\Temp\SecOps.conf

Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/nxlogADcontext.conf" -Outfile C:\Windows\Temp\adcontext.conf

Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/nxlogDNS.conf" -Outfile C:\Windows\Temp\dns.conf

Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/nxlogPwrSh-config.conf" -Outfile C:\Windows\Temp\pwrsh.conf

Invoke-WebRequest -Uri "raw.githubusercontent.com/cybriant/NxLogRepo/refs/heads/main/nxlogwinDHCP.conf" -Outfile C:\Windows\Temp\dhcp.conf

dir *.conf

Move-Item -Path .\*.conf -Destination "C:\Program Files\nxlog\conf\nxlog.d\"
cd "\program files\nxlog\conf\"
Move-item -Path "c:\Program Files\nxlog\conf\nxlog.conf" -Destination "C:\Program Files\nxlog\conf\nxlog.old"
Move-Item -Path "C:\Program Files\nxlog\conf\nxlog.d\master.conf" -Destination "C:\Program Files\nxlog\conf\nxlog.conf"

Restart-Service nxlog
Get-Content -tail 40 "C:\Program Files\nxlog\data\nxlog.log" 

