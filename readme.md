# **Background**
When running Docker For Windows on a VPN, company Network, or from home, it was necessary to frequently switch between IP addresses. This caused Docker to take long start-ups by attempting to use the previous IP. I didn't particularly like this aspect about Docker, so I wrote this script that will allow one to dynamically update the IP address associated with their Docker instance either when they login to their device or when they choose to update the IP address by running the script using the convenient shortcut.

# **Instructions for Syncing Docker with VPN/Dynamic IP**
1. Ensure CNTLM is working on your computer
1. Ensure you have docker for windows installed on your device
	1. Pre-requisites:
		1. Windows 10
		1. 64-bit device

1. Extract the contents of this repository to `<c:\Program Files\Docker>` or wherever you have Docker installed:
	1. Add the 'VPN IP Sync Docker - (shortcut)' to your desktop
		1. this shortcut will trigger an IP sync manually by calling the dockerIpSync.ps1 powershell script through a `<.bat>`. You may need to update the `<.ps1>` with the path to your Docker Directory if it is different from the default.
		1. Use this shortcut whenever you connect to a new network and/or need to refresh your IP address

1. Run the following script in powershell (administrator) to schedule a
    logon task that will automatically sync your IP to Docker when you login to your device:
	1. run the script below in powershell:
	`<$trigger = New-JobTrigger -AtLogOn -RandomDelay 00:01:30>`
	`<Register-ScheduledJob -Trigger $trigger -FilePath 'C:\path\to\Docker\dockerIpSync.ps1' -Name dockerIpSync>`
	1. If the task doesn't execute (and it might not for a variety of reasons), then run the VPN Sync Manually using the shortcut. You can also check if the job ran by running: `<Get-Job -Name dockerIpSync>` in your powershell window

1. Quit and reopen Docker if it was open when you synced IP addresses

#**Questions/Concerns/Feedback**
Feel free to reach out to me on GitHub, submit a bug, or pull request.

	
