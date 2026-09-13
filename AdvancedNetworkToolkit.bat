@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Advanced Windows Network Toolkit v3.0
:: ============================================================
:: Author: Network Toolkit
:: Purpose: Diagnose and repair common Windows network problems
:: Requires: Windows 10/11 + Administrator privileges
:: ============================================================

title Advanced Windows Network Toolkit v3.0
color 0A

:: ------------------------------------------------------------
:: Check Administrator Rights
:: ------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    cls
    echo ============================================================
    echo ERROR: Administrator privileges are required.
    echo ============================================================
    echo.
    echo Right-click this BAT file and select:
    echo "Run as administrator"
    echo.
    pause
    exit /b
)

:MENU
cls
color 0A

echo ============================================================
echo          ADVANCED WINDOWS NETWORK TOOLKIT v3.0
echo ============================================================
echo.
echo DIAGNOSTICS
echo ------------------------------------------------------------
echo [1]  Show Full IP Configuration
echo [2]  Show Basic Network Information
echo [3]  Ping Google
echo [4]  Continuous Ping
echo [5]  Ping Default Gateway
echo [6]  Test Internet Connectivity
echo [7]  Test DNS Resolution
echo [8]  Show DNS Cache
echo [9]  Show Routing Table
echo [10] Show ARP Cache
echo [11] Show Active Network Sessions
echo [12] Show Network Adapters
echo [13] Show Wi-Fi Information
echo.
echo REPAIR
echo ------------------------------------------------------------
echo [14] Flush DNS Cache
echo [15] Renew IP Address
echo [16] Restart Network Adapter
echo [17] Reset Winsock
echo [18] Reset TCP/IP Stack
echo [19] Quick Network Fix
echo [20] Full Network Repair
echo.
echo WINDOWS TOOLS
echo ------------------------------------------------------------
echo [21] Open Network Connections
echo [22] Open Wi-Fi Settings
echo [23] Open Device Manager
echo [24] Open Network Troubleshooter
echo [25] Restart Windows Explorer
echo.
echo REPORT
echo ------------------------------------------------------------
echo [26] Generate Network Report
echo.
echo [27] Exit
echo.
echo ============================================================
set /p "choice=Select Option: "

if "%choice%"=="1"  goto IPCONFIG
if "%choice%"=="2"  goto BASICINFO
if "%choice%"=="3"  goto PINGGOOGLE
if "%choice%"=="4"  goto CONTPING
if "%choice%"=="5"  goto PINGGATEWAY
if "%choice%"=="6"  goto INTERNET
if "%choice%"=="7"  goto DNS
if "%choice%"=="8"  goto DNSCACHE
if "%choice%"=="9"  goto ROUTE
if "%choice%"=="10" goto ARP
if "%choice%"=="11" goto NETSTAT
if "%choice%"=="12" goto ADAPTERS
if "%choice%"=="13" goto WIFIINFO

if "%choice%"=="14" goto FLUSHDNS
if "%choice%"=="15" goto RENEW
if "%choice%"=="16" goto RESTARTADAPTER
if "%choice%"=="17" goto WINSOCK
if "%choice%"=="18" goto TCPRESET
if "%choice%"=="19" goto QUICKFIX
if "%choice%"=="20" goto FULLREPAIR

if "%choice%"=="21" goto NCPA
if "%choice%"=="22" goto WIFISETTINGS
if "%choice%"=="23" goto DEVICE
if "%choice%"=="24" goto TROUBLE
if "%choice%"=="25" goto EXPLORER

if "%choice%"=="26" goto REPORT
if "%choice%"=="27" goto EXIT

echo.
echo Invalid selection.
timeout /t 2 >nul
goto MENU


:: ============================================================
:: 1. FULL IP CONFIGURATION
:: ============================================================

:IPCONFIG
cls
echo ============================================================
echo FULL IP CONFIGURATION
echo ============================================================
echo.

ipconfig /all

goto END


:: ============================================================
:: 2. BASIC NETWORK INFORMATION
:: ============================================================

:BASICINFO
cls
echo ============================================================
echo BASIC NETWORK INFORMATION
echo ============================================================
echo.

echo Computer Name:
hostname

echo.
echo Network Adapters:
echo ------------------------------------------------------------
ipconfig

echo.
echo Default Gateway:
echo ------------------------------------------------------------
ipconfig | findstr /i "Default Gateway"

echo.
echo DNS Servers:
echo ------------------------------------------------------------
ipconfig /all | findstr /i "DNS Servers"

goto END


:: ============================================================
:: 3. PING GOOGLE
:: ============================================================

:PINGGOOGLE
cls
echo ============================================================
echo PING GOOGLE
echo ============================================================
echo.
echo Testing DNS + Internet connectivity...
echo.

ping google.com -n 10

goto END


:: ============================================================
:: 4. CONTINUOUS PING
:: ============================================================

:CONTPING
cls
echo ============================================================
echo CONTINUOUS PING
echo ============================================================
echo.
echo Press CTRL+C to stop.
echo.

ping 8.8.8.8 -t

goto END


:: ============================================================
:: 5. PING DEFAULT GATEWAY
:: ============================================================

:PINGGATEWAY
cls
echo ============================================================
echo PING DEFAULT GATEWAY
echo ============================================================
echo.

for /f "tokens=2 delims=:" %%A in (
    'ipconfig ^| findstr /i "Default Gateway"'
) do (
    set "GATEWAY=%%A"
    set "GATEWAY=!GATEWAY: =!"
    if not "!GATEWAY!"=="" goto GOTGATEWAY
)

echo Unable to automatically detect the default gateway.
echo.
pause
goto MENU

:GOTGATEWAY

echo Gateway detected: !GATEWAY!
echo.
echo Testing gateway...
echo.

ping !GATEWAY! -n 10

goto END


:: ============================================================
:: 6. INTERNET CONNECTIVITY TEST
:: ============================================================

:INTERNET
cls
echo ============================================================
echo INTERNET CONNECTIVITY TEST
echo ============================================================
echo.

echo [1/3] Testing localhost...
ping 127.0.0.1 -n 2

echo.
echo [2/3] Testing Google DNS IP...
ping 8.8.8.8 -n 4

echo.
echo [3/3] Testing Google domain...
ping google.com -n 4

goto END


:: ============================================================
:: 7. DNS RESOLUTION TEST
:: ============================================================

:DNS
cls
echo ============================================================
echo DNS RESOLUTION TEST
echo ============================================================
echo.

echo Testing google.com...
nslookup google.com

echo.
echo Testing cloudflare.com...
nslookup cloudflare.com

goto END


:: ============================================================
:: 8. DNS CACHE
:: ============================================================

:DNSCACHE
cls
echo ============================================================
echo DNS CACHE
echo ============================================================
echo.

ipconfig /displaydns

goto END


:: ============================================================
:: 9. ROUTING TABLE
:: ============================================================

:ROUTE
cls
echo ============================================================
echo ROUTING TABLE
echo ============================================================
echo.

route print

goto END


:: ============================================================
:: 10. ARP CACHE
:: ============================================================

:ARP
cls
echo ============================================================
echo ARP CACHE
echo ============================================================
echo.

arp -a

goto END


:: ============================================================
:: 11. ACTIVE NETWORK SESSIONS
:: ============================================================

:NETSTAT
cls
echo ============================================================
echo ACTIVE NETWORK SESSIONS
echo ============================================================
echo.

netstat -ano

echo.
echo PID can be matched with Task Manager.
echo.

goto END


:: ============================================================
:: 12. NETWORK ADAPTERS
:: ============================================================

:ADAPTERS
cls
echo ============================================================
echo NETWORK ADAPTERS
echo ============================================================
echo.

netsh interface show interface

echo.
echo Detailed adapter information:
echo ------------------------------------------------------------

powershell -NoProfile -Command "Get-NetAdapter | Format-Table -AutoSize Name,InterfaceDescription,Status,LinkSpeed,MacAddress"

goto END


:: ============================================================
:: 13. WI-FI INFORMATION
:: ============================================================

:WIFIINFO
cls
echo ============================================================
echo WI-FI INFORMATION
echo ============================================================
echo.

netsh wlan show interfaces

echo.
echo Saved Wi-Fi profiles:
echo ------------------------------------------------------------

netsh wlan show profiles

goto END


:: ============================================================
:: 14. FLUSH DNS
:: ============================================================

:FLUSHDNS
cls
echo ============================================================
echo FLUSH DNS CACHE
echo ============================================================
echo.

ipconfig /flushdns

echo.
echo DNS cache has been flushed.

goto END


:: ============================================================
:: 15. RENEW IP
:: ============================================================

:RENEW
cls
echo ============================================================
echo RENEW IP ADDRESS
echo ============================================================
echo.
echo This may temporarily disconnect your network.
echo.

choice /c YN /n /m "Continue? [Y/N]: "

if errorlevel 2 goto MENU

ipconfig /renew

echo.
echo IP renewal completed.

goto END


:: ============================================================
:: 16. RESTART NETWORK ADAPTER
:: ============================================================

:RESTARTADAPTER
cls
echo ============================================================
echo RESTART NETWORK ADAPTER
echo ============================================================
echo.

netsh interface show interface

echo.
echo Enter the EXACT adapter name.
echo Example: Wi-Fi
echo Example: Ethernet
echo.

set /p "ADAPTER=Adapter name: "

if "%ADAPTER%"=="" (
    echo.
    echo No adapter entered.
    pause
    goto MENU
)

echo.
echo Disabling adapter...
netsh interface set interface name="%ADAPTER%" admin=disabled

timeout /t 3 >nul

echo Enabling adapter...
netsh interface set interface name="%ADAPTER%" admin=enabled

echo.
echo Adapter restart completed.

goto END


:: ============================================================
:: 17. WINSOCK RESET
:: ============================================================

:WINSOCK
cls
echo ============================================================
echo RESET WINSOCK
echo ============================================================
echo.
echo This operation may require a restart.
echo.

choice /c YN /n /m "Continue? [Y/N]: "

if errorlevel 2 goto MENU

netsh winsock reset

echo.
echo ============================================================
echo Winsock reset completed.
echo A Windows restart is recommended.
echo ============================================================

goto END


:: ============================================================
:: 18. TCP/IP RESET
:: ============================================================

:TCPRESET
cls
echo ============================================================
echo RESET TCP/IP STACK
echo ============================================================
echo.
echo This operation may affect network configuration.
echo.

choice /c YN /n /m "Continue? [Y/N]: "

if errorlevel 2 goto MENU

netsh int ip reset

echo.
echo ============================================================
echo TCP/IP reset completed.
echo A Windows restart is recommended.
echo ============================================================

goto END


:: ============================================================
:: 19. QUICK NETWORK FIX
:: ============================================================

:QUICKFIX
cls
echo ============================================================
echo QUICK NETWORK FIX
echo ============================================================
echo.
echo This performs basic, low-risk repairs:
echo.
echo 1. Flush DNS
echo 2. Renew IP address
echo.

choice /c YN /n /m "Continue? [Y/N]: "

if errorlevel 2 goto MENU

echo.
echo [1/2] Flushing DNS...
ipconfig /flushdns

echo.
echo [2/2] Renewing IP...
ipconfig /renew

echo.
echo ============================================================
echo Quick network repair completed.
echo ============================================================

goto END


:: ============================================================
:: 20. FULL NETWORK REPAIR
:: ============================================================

:FULLREPAIR
cls
echo ============================================================
echo FULL NETWORK REPAIR
echo ============================================================
echo.
echo WARNING:
echo This will:
echo.
echo 1. Flush DNS
echo 2. Release IP
echo 3. Renew IP
echo 4. Reset Winsock
echo 5. Reset TCP/IP
echo.
echo Your network connection may temporarily disconnect.
echo A Windows restart is recommended afterward.
echo.

choice /c YN /n /m "Continue? [Y/N]: "

if errorlevel 2 goto MENU

echo.
echo ============================================================
echo STEP 1 - FLUSH DNS
echo ============================================================
ipconfig /flushdns

echo.
echo ============================================================
echo STEP 2 - RELEASE IP
echo ============================================================
ipconfig /release

echo.
echo ============================================================
echo STEP 3 - RENEW IP
echo ============================================================
ipconfig /renew

echo.
echo ============================================================
echo STEP 4 - RESET WINSOCK
echo ============================================================
netsh winsock reset

echo.
echo ============================================================
echo STEP 5 - RESET TCP/IP
echo ============================================================
netsh int ip reset

echo.
echo ============================================================
echo FULL NETWORK REPAIR COMPLETED
echo ============================================================
echo.
echo RECOMMENDATION:
echo Restart Windows before testing the network again.
echo.

goto END


:: ============================================================
:: 21. NETWORK CONNECTIONS
:: ============================================================

:NCPA
start ncpa.cpl
goto END


:: ============================================================
:: 22. WI-FI SETTINGS
:: ============================================================

:WIFISETTINGS
start ms-settings:network-wifi
goto END


:: ============================================================
:: 23. DEVICE MANAGER
:: ============================================================

:DEVICE
start devmgmt.msc
goto END


:: ============================================================
:: 24. NETWORK TROUBLESHOOTER
:: ============================================================

:TROUBLE
cls
echo ============================================================
echo NETWORK TROUBLESHOOTER
echo ============================================================
echo.

echo Attempting to open Windows network diagnostics...
echo.

msdt.exe /id NetworkDiagnosticsNetworkAdapter

goto END


:: ============================================================
:: 25. RESTART WINDOWS EXPLORER
:: ============================================================

:EXPLORER
cls
echo ============================================================
echo RESTART WINDOWS EXPLORER
echo ============================================================
echo.

taskkill /f /im explorer.exe
timeout /t 2 >nul
start explorer.exe

echo.
echo Windows Explorer restarted.

goto END


:: ============================================================
:: 26. NETWORK REPORT
:: ============================================================

:REPORT
cls
echo ============================================================
echo GENERATE NETWORK REPORT
echo ============================================================
echo.

set "REPORT=%USERPROFILE%\Desktop\NetworkReport.txt"

echo Generating report...
echo Please wait...
echo.

(
echo ============================================================
echo WINDOWS NETWORK DIAGNOSTIC REPORT
echo ============================================================
echo Generated: %date% %time%
echo Computer: %COMPUTERNAME%
echo User: %USERNAME%
echo ============================================================
echo.

echo ============================================================
echo IP CONFIGURATION
echo ============================================================
ipconfig /all

echo.
echo ============================================================
echo ROUTING TABLE
echo ============================================================
route print

echo.
echo ============================================================
echo ARP CACHE
echo ============================================================
arp -a

echo.
echo ============================================================
echo NETWORK ADAPTERS
echo ============================================================
netsh interface show interface

echo.
echo ============================================================
echo DNS CONFIGURATION
echo ============================================================
nslookup google.com

echo.
echo ============================================================
echo ACTIVE NETWORK CONNECTIONS
echo ============================================================
netstat -ano

echo.
echo ============================================================
echo WIFI INFORMATION
echo ============================================================
netsh wlan show interfaces

echo.
echo ============================================================
echo END OF REPORT
echo ============================================================
) > "%REPORT%"

echo.
echo ============================================================
echo REPORT CREATED
echo ============================================================
echo.
echo Location:
echo %REPORT%
echo.

start "" notepad "%REPORT%"

goto END


:: ============================================================
:: END / RETURN TO MENU
:: ============================================================

:END
echo.
echo ============================================================
pause
goto MENU


:: ============================================================
:: EXIT
:: ============================================================

:EXIT
cls
echo ============================================================
echo Thank you for using Advanced Windows Network Toolkit v3.0
echo ============================================================
echo.
timeout /t 2 >nul
exit /b