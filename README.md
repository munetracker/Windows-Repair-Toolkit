# Advanced Windows Network Toolkit v3.0

A menu-based Windows `.bat` utility for diagnosing and repairing common network problems.

## Requirements

* Windows 10 or Windows 11
* Administrator privileges
* Active network adapter
* Command Prompt
* PowerShell (included with Windows)

## Installation

1. Create a file named:

`AdvancedNetworkToolkit.bat`

2. Paste the complete BAT code into the file.
3. Save it.
4. Right-click the file.
5. Select **Run as administrator**.

Administrator access is required for several repair operations.

---

# Main Menu

## Diagnostics

### 1. Show Full IP Configuration

Runs:

`ipconfig /all`

Shows detailed information about:

* IPv4 address
* IPv6 address
* Subnet mask
* Default gateway
* DHCP
* DNS servers
* MAC address
* Network adapters

Use this when you need complete network configuration information.

---

### 2. Show Basic Network Information

Displays a simplified overview of:

* Computer name
* Network adapters
* Default gateway
* DNS servers

Useful for quickly checking your configuration.

---

### 3. Ping Google

Runs:

`ping google.com -n 10`

This tests both:

* DNS resolution
* Internet connectivity

If `google.com` cannot be resolved, DNS may be the problem.

---

### 4. Continuous Ping

Runs:

`ping 8.8.8.8 -t`

Continuously tests Google's DNS server.

Useful for detecting:

* Random disconnections
* Packet loss
* High latency
* Unstable Wi-Fi

Press **CTRL+C** to stop.

---

### 5. Ping Default Gateway

Automatically finds the computer's default gateway and sends ping requests to it.

Example:

`192.168.1.1`

This helps determine whether your computer can communicate with your router.

If the gateway cannot be reached, the problem is likely between the computer and the local network.

---

### 6. Test Internet Connectivity

Performs three tests:

1. `127.0.0.1` — local TCP/IP stack
2. `8.8.8.8` — Internet connectivity
3. `google.com` — Internet + DNS

This provides a quick way to identify where the connection is failing.

---

### 7. Test DNS Resolution

Uses:

`nslookup`

Tests whether Windows can resolve domain names.

Example:

`google.com → IP address`

If IP addresses work but domain names don't, DNS may be the problem.

---

### 8. Show DNS Cache

Runs:

`ipconfig /displaydns`

Shows DNS records currently cached by Windows.

Useful when troubleshooting incorrect or outdated DNS information.

---

### 9. Show Routing Table

Runs:

`route print`

Shows how Windows decides where network traffic should go.

Useful for advanced troubleshooting involving:

* Multiple network adapters
* VPNs
* Static routes
* Incorrect gateways

---

### 10. Show ARP Cache

Runs:

`arp -a`

Shows local IP-to-MAC address mappings.

Useful for examining devices on the local network.

---

### 11. Show Active Network Sessions

Runs:

`netstat -ano`

Shows current network connections and listening ports.

The PID can be matched with Windows Task Manager to identify the process.

---

### 12. Show Network Adapters

Displays:

* Adapter name
* Adapter description
* Status
* Link speed
* MAC address

Useful for identifying whether Ethernet/Wi-Fi adapters are actually enabled.

---

### 13. Show Wi-Fi Information

Runs:

`netsh wlan show interfaces`

Displays information about the current Wi-Fi connection.

It can show information such as:

* SSID
* Signal
* Radio type
* Channel
* Connection state

It also displays saved Wi-Fi profile names.

---

# Repair Tools

## 14. Flush DNS Cache

Runs:

`ipconfig /flushdns`

Clears cached DNS records.

Use this when:

* Websites resolve incorrectly
* DNS was recently changed
* A domain points to an old IP
* Some websites work while others don't

This is generally a low-risk repair.

---

## 15. Renew IP Address

Runs:

`ipconfig /renew`

Requests a new DHCP configuration from the network.

Useful when:

* The computer has an invalid IP
* DHCP failed
* The computer cannot communicate with the router

The network may temporarily disconnect.

---

## 16. Restart Network Adapter

Allows you to enter an adapter name such as:

`Wi-Fi`

or:

`Ethernet`

The toolkit then:

1. Disables the adapter
2. Waits
3. Enables the adapter again

This is useful when the network adapter appears connected but isn't functioning correctly.

---

## 17. Reset Winsock

Runs:

`netsh winsock reset`

Winsock is part of Windows networking.

A Winsock reset can help with certain corrupted or misconfigured networking problems.

A reboot is recommended afterward.

---

## 18. Reset TCP/IP Stack

Runs:

`netsh int ip reset`

Resets Windows TCP/IP configuration.

Useful for deeper network configuration problems.

A reboot is recommended.

---

## 19. Quick Network Fix

Performs:

1. Flush DNS
2. Renew IP

This is intended to be the first repair option to try.

It is less aggressive than a full network reset.

---

## 20. Full Network Repair

Performs:

1. Flush DNS
2. Release IP
3. Renew IP
4. Reset Winsock
5. Reset TCP/IP

This is intended for more serious Windows networking problems.

### Important

Your Internet connection may temporarily disappear.

Restart Windows after running this option.

Do not use this as the first troubleshooting step if a simple DNS flush or adapter restart may solve the problem.

---

# Windows Tools

## 21. Open Network Connections

Opens:

`ncpa.cpl`

This gives access to Windows network adapters.

You can:

* Enable/disable adapters
* View adapter properties
* Configure IPv4
* Configure DNS
* Configure IPv6

---

## 22. Open Wi-Fi Settings

Opens Windows Wi-Fi settings directly.

Useful for quickly checking:

* Wi-Fi networks
* Connection status
* Wi-Fi configuration

---

## 23. Open Device Manager

Opens:

`devmgmt.msc`

Useful for checking network hardware and drivers.

Look under:

**Network adapters**

You can check whether a network adapter has:

* Driver errors
* Disabled status
* Warning icons

---

## 24. Open Network Troubleshooter

Attempts to launch Windows network diagnostics.

Depending on the Windows version, Microsoft may have deprecated or changed some legacy troubleshooting tools.

If it doesn't open on a newer Windows version, use Windows Settings' built-in network troubleshooting features.

---

## 25. Restart Windows Explorer

Restarts:

`explorer.exe`

This is not directly a network repair.

It is included because restarting Explorer can fix Windows UI/network-share display issues.

---

# Network Report

## 26. Generate Network Report

Creates:

`NetworkReport.txt`

on the Desktop.

The report contains:

* Computer information
* Full IP configuration
* Routing table
* ARP cache
* Network adapters
* DNS test
* Active network connections
* Wi-Fi information

The report automatically opens in Notepad.

This is useful when sending network information to a technician or keeping a troubleshooting record.

---

# Recommended Troubleshooting Order

When the Internet isn't working, don't immediately use **Full Network Repair**.

Use this order:

### Step 1 — Check adapter

Choose:

**12. Show Network Adapters**

Make sure Wi-Fi/Ethernet is enabled.

### Step 2 — Check gateway

Choose:

**5. Ping Default Gateway**

If this fails, investigate the local network/router/Wi-Fi connection.

### Step 3 — Check Internet

Choose:

**6. Test Internet Connectivity**

If `8.8.8.8` works but `google.com` doesn't, DNS is likely the problem.

### Step 4 — Test DNS

Choose:

**7. Test DNS Resolution**

### Step 5 — Quick repair

Choose:

**19. Quick Network Fix**

### Step 6 — Restart adapter

Choose:

**16. Restart Network Adapter**

### Step 7 — Full repair

Only if the problem persists:

**20. Full Network Repair**

Then restart Windows.

---

# What the Toolkit Does NOT Do

This toolkit does not:

* Hack networks
* Crack Wi-Fi passwords
* Change router settings
* Modify ISP settings
* Automatically change DNS servers
* Automatically change IP addresses to random values
* Disable Windows Firewall
* Modify antivirus settings
* Delete user files

It focuses on Windows network diagnostics and standard network repair commands.

---

# Safety Notes

Some commands can temporarily disconnect your computer.

Be especially careful with:

* IP release
* IP renewal
* Winsock reset
* TCP/IP reset
* Full Network Repair
* Network adapter restart

If the computer uses:

* Static IP addresses
* Corporate VPN
* Enterprise network configuration
* Custom DNS
* Proxy configuration
* Special routing rules

a reset may affect that configuration.

For normal home DHCP networks, these operations are generally appropriate for troubleshooting.

---

# Version

**Advanced Windows Network Toolkit v3.0**

Main improvements over v2:

* Automatic gateway detection
* DNS testing
* Internet connectivity testing
* Network adapter information
* Wi-Fi information
* Adapter restart
* Quick repair
* Full repair confirmation
* Network report generation
* Safer confirmation prompts
* Better menu organization
* More detailed diagnostics
