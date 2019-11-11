# Setting up dev environment for KochiOrgBook Project

### QuickStart Steps:
* Use 64 bit <a href="https://ubuntu.com/download/desktop/thank-you?version=18.04.3&architecture=amd64">Ubuntu 18.04 ISO</a> Distribution 
* Use <a href="https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe">VirtualBox </a> as Hypervisor
* Once Ubuntu 18.04 is turned on, install <a href="https://github.com/EtricKombat/KOBDevOps/wiki/1.Manuel-Steps-to-setup-KOB">git </a>  in your system

* Clone this repo :
        
        git clone https://github.com/EtricKombat/KOBDevOps.git and try out the shell commands listed at the bottom of this page


 




## Table of Content [for References]

<table>
<tr><th>No:</th><th>Topic </th><th>Description</th></tr>
<tr><td>1.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/wiki/1.Manuel-Steps-to-setup-KOB">Manuelly setting up KOB Project</a></td><td>You can find the Manuel steps (bash script) of each steps involved in KochiOrgBook (KOB) Setup here</td></tr>
<tr><td>2.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/wiki/2.Asciinema-Recordings">Asciinema Recordings</a></td><td>You can find the Asciinema recordings of each steps involved in KochiOrgBook Setup here</td></tr><tr><td>3.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/wiki/3.Automated-Scripts">Automated Dev Environment Setup Script</a></td><td>You can find the automated bash script of KochiOrgBook Setup here</td></tr>

<tr><td>4.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/issues?q=is%3Aopen+is%3Aissue">Opened Issue</a></td><td>Collection of known issue</td></tr>
<tr><td>5.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/issues?q=is%3Aissue+is%3Aclosed">Closed Issue</a></td><td>Collection of known issue</td></tr>

<tr><td>9.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/wiki/Contact-us">Contact Us / Contribute with us</a></td><td>Community meetup details</td></tr>
</table>

## How to use the scripts 
The script should be executed in the listed formats : 

```code

 KOB install              // install default projects i.e KOBVON, KOBDflow,KOBConnect, KOBRegistry, TheKochOrgBook
 KOB install KOBVON       // Deploy KOBVON for testing
 KOB install --dev All    // install all the dev environment to do development
 KOB install --dev KOBVON // to install just the KOBVON project for development
 
 KOB install --dev KOBVON 
 KOB install --dev KOB      
 KOB install --dev TOB –namespace http://github/hyperledgerkochi
```
