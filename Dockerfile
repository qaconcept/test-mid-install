#Windows Servercore base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019
LABEL maintainer "darien.buchanan@virtustream.com"

#copy files to use for testing install
COPY .env /
COPY install-test.ps1 /

ARG SN_USER
ARG SN_PASSWD
ARG SN_MID_NAME
ARG SN_INSTANCE

#1. Set Credential variable 2. Install NuGet 3. Install ServiceNow-MIDServer module 4. Install SNOW Midserver
RUN powershell -Command \
$User='%SN_USER%' ; \
$PWord=ConvertTo-SecureString -String '%SN_PASSWD%' -AsPlainText -Force ; \
$Credential=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord ; \
Find-PackageProvider -Name "NuGet" -AllVersions ; \
Install-PackageProvider -Name "NuGet" -Force ; \
Install-Module -Name ServiceNow-MIDServer -Force ; \
Install-ServiceNowMIDServer -ServiceNowInstanceName '%SN_INSTANCE%' -Name '%SN_MID_NAME%' -Credential $Credential
