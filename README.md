# docker ServiceNow MID Server

This is a Dockerfile to set up "ServiceNow MID Server" - (http://wiki.servicenow.com/index.php?title=MID_Server_Installation)

## Build from dockerfile and start instance

```
1. git clone 
   -the following files will added to your current directory: 
      a. .env (sets variables)
      b. docker-compose.yml 
      c. Dockerfile (creates image)
      d. install-midserver-win-container.bat (only use if install via batch, see below)
      e. install-test.ps1
2. docker-compose build
3. docker run -i --name <container name> <image name>
      ex: docker run -i --name sn-mid-server-win sbuchanan/sn-mid-server-win:1.0

How To Use: 
-User will be in the running container and the service now mid server will be up and available. 
--to test install from container c:/ enter 'powershell -command "& { . c:\install-test.ps1; install-tests }"
---will return True or false for 1. Mid Server Service running 2. Instance is pingable 3. agent0.log.0.lck file is present

-cd C:\ServiceNow\sn-mid-server\agent to see available functions (ie: start.bat, stop.bat)
--To stop, enter stop.bat
--To start, enter start.bat

After steps above use the following to start, attach, and stop container...
-docker start <container-name>
-docker attach <container-name>
--'Exit' to stop and exit container when attached
-docker stop <container-name>
```

## Alternative install methods
### Manual install on Windows Container
```
1. Start and access container (*must be windows servercore container)
2. Once in container prompt 'start powershell'
3. Install-Module -Name ServiceNow-MIDServer
4. Install-ServiceNowMIDServer -ServiceNowInstanceName <string> -Name <string> -Credential <PSCredential>
```
### Install via .bat script
```
1. git clone 
   -the following files will be in current directory: 
      a. .env (sets variables)      
      b. docker-compose.yml
      c. Dockerfile (creates image)      
      d. install-midserver-win-container.bat
2. execute install-midserver-win-container.bat

```

## Notes:
```
-Unit Test Env = personal serviceNow dev instance (Madrid & New York)
-Base image=mcr.microsoft.com/windows/servercore:ltsc2019
-Install Package=Powershell package: ServiceNow-MIDServer ( https://www.powershellgallery.com/packages/ServiceNow-MIDServer/1.1.3)
```
