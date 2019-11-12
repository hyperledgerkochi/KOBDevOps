# Setting up dev environment for KochiOrgBook Project

### QuickStart Guide:
* **Step 1:**
Download & use <a href="https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe">Oracle's VirtualBox </a> as Hypervisor

* **Step 2:**
Download & use 64 bit <a href="https://ubuntu.com/download/desktop/thank-you?version=18.04.3&architecture=amd64">Ubuntu 18.04 ISO</a> Distribution
* **Step 3:**
Once Ubuntu 18.04 is hosted on VirtualBox, <a href="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/AutomatedScript.md">install git </a>  in your system

* **Step 4:**
Clone this repo :
        
        git clone https://github.com/EtricKombat/KOBDevOps.git and try out the shell commands listed at the bottom of this page

* **Step 5:**
  Docker hub <a href="https://hub.docker.com/signup">signing up</a> necessary [requires to <a href="https://id.docker.com/login/?next=%2Fid%2Foauth%2Fauthorize%2F%3Fclient_id%3D43f17c5f-9ba4-4f13-853d-9d0074e349a7%26nonce%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI0M2YxN2M1Zi05YmE0LTRmMTMtODUzZC05ZDAwNzRlMzQ5YTciLCJleHAiOjE1NzM1NDEzNTAsImlhdCI6MTU3MzU0MTA1MCwicmZwIjoiQ1B0Q1VVLUNUUmsxNnhWSlN0TFlqUT09IiwidGFyZ2V0X2xpbmtfdXJpIjoiaHR0cHM6Ly9odWIuZG9ja2VyLmNvbSJ9.v07IZvFlmimZkanC1VgC-FN2K0paxjFvAMqyXEiirtk%26redirect_uri%3Dhttps%253A%252F%252Fhub.docker.com%252Fsso%252Fcallback%26response_type%3Dcode%26scope%3Dopenid%26state%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI0M2YxN2M1Zi05YmE0LTRmMTMtODUzZC05ZDAwNzRlMzQ5YTciLCJleHAiOjE1NzM1NDEzNTAsImlhdCI6MTU3MzU0MTA1MCwicmZwIjoiQ1B0Q1VVLUNUUmsxNnhWSlN0TFlqUT09IiwidGFyZ2V0X2xpbmtfdXJpIjoiaHR0cHM6Ly9odWIuZG9ja2VyLmNvbSJ9.v07IZvFlmimZkanC1VgC-FN2K0paxjFvAMqyXEiirtk">sign in</a> as an docker user ]


## Table of Content [for References]

<table>
<tr><th>No:</th><th>Topic </th><th>Description</th></tr>
<tr><td>1.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/ManuelSteps.md">Manuel Step</a></td><td>You can find the Manuel steps (bash script) of each steps involved in KochiOrgBook (KOB) Setup here</td></tr>
<tr><td>2.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/AutomatedScript.md">Automated Script</a></td><td>You can find the automated bash script of KochiOrgBook Setup here</td></tr>

<tr><td>3.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/issues?q=is%3Aopen+is%3Aissue">Opened Issue</a></td><td>Collection of known issue</td></tr>
<tr><td>4.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/issues?q=is%3Aissue+is%3Aclosed">Closed Issue</a></td><td>Collection of known issue</td></tr>

<tr><td>5.</td><td><a href="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/ContactUs_ContributeWithUs.md">Contact us Contribute with us !</a></td><td>Community meetup details</td></tr>
</table>


## How to use the scripts 
The script should be executed in the listed formats : 

```code

 ./KOB install              // install default projects i.e KOBVON, KOBDflow,KOBConnect, KOBRegistry, TheKochOrgBook
 ./KOB install KOBVON       // Deploy KOBVON for testing
 ./KOB install --dev All    // install all the dev environment to do development
 ./KOB install --dev KOBVON // to install just the KOBVON project for development
 

 ./KOB install --dev KOB      
 ./KOB install --dev TOB –namespace http://github/hyperledgerkochi
```

