## Pre-requisites
* OS should be Ubuntu 18.04
* minimum of 4GB RAM require for Virtual Machine


### QuickStart Guide:
* Use 64 bit <a href="https://ubuntu.com/download/desktop/thank-you?version=18.04.3&architecture=amd64">Ubuntu 18.04 ISO</a> Distribution 
* Use <a href="https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe">VirtualBox </a> as Hypervisor .

This steps should perform on an 64 bit machine.



<table>

<tr><th>No:</th><th>Commands : </th></tr>
<tr><th>1.0:</th><th>Ubuntu installation - Command</th></tr>
<tr><td>1.1</td><td>apt-get update -y</td></tr>
<tr><td>1.2</td><td>apt-get dist-upgrade -y</td></tr>
<tr><th>2.0:</th><th>Git installation - Command</th></tr>
<tr><td>2.1</td><td>apt install git -y</td></tr>
 <tr><td>2.2</td><td>git --version</td></tr>
 <tr><td>2.3</td><td>git config --global user.name "username"</td></tr>
 <tr><td>2.4</td><td>git config --global user.email "email"</td></tr>\
 <tr><td>2.5</td><td>git config --global http.sslVerify false</td></tr>
 <tr><td>2.6</td><td>apt install ca-certificates</td></tr>
 <tr><td>2.7</td><td>git config --system http.sslcainfo /bin/curl-ca-bundle.crt</td></tr>
<tr><th>3.0:</th><th>Python installation - Commands</th></tr>
<tr><td>3.1</td><td>apt install software-properties-common -y</td></tr>
 <tr><td>3.2</td><td>sudo -E add-apt-repository ppa:ubuntu-toolchain-r/ppa</td></tr>
<tr><td>3.3</td><td>apt install Python3.7 -y</td></tr>
<tr><th>4.0:</th><th>Docker installation - Commands</th></tr>
<tr><td>4.1</td><td>sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io</td></tr>
 <tr><td>4.2</td><td>apt-get update -y</td></tr>
 <tr><td>4.3</td><td>apt install docker.io</td></tr>
 <tr><td>4.4</td><td>apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y</td></tr>
 <tr><td>4.5</td><td>curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -</td></tr>
 <tr><td>4.6</td><td>apt-key fingerprint 0EBFCD88</td></tr>
 <tr><td>4.7</td><td>lsb_release -cs</td></tr>
 <tr><td>4.8</td><td>add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"</td<</tr>
 <tr><td>4.9</td><td>apt-get update -y</td></tr>
<tr><td>4.10</td><td>apt-get install docker-ce docker-ce-cli containerd.io -y</td></tr>
<tr><td>4.11</td><td>docker run hello-world</td></tr>
<tr><th>5.0:</th><th>Docker Compose installation - Commands</th></tr>
<tr><td>5.1</td><td>curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose</td></tr>
<tr><td>5.2</td><td>chmod +x /usr/local/bin/docker-compose</td></tr>
<tr><td>5.3</td><td>docker --version</td></tr>
<tr><td>5.4</td><td>docker-compose --version</td></tr>
<tr><td>5.5</td><td>systemctl start docker</td></tr>
<tr><td>5.6</td><td>systemctl enable docker</td></tr>
<tr><td>5.7</td><td>docker login</td></tr>
<tr><th>6.0:</th><th>NPM installation - Commands</th></tr>
<tr><td>6.1</td><td>npm config rm proxy</td></tr>
<tr><td>6.2</td><td>npm config rm proxy --global</td></tr>
<tr><td>6.3</td><td>npm config rm https-proxy</td></tr>
<tr><td>6.4</td><td>npm config rm https-proxy --global</td></tr>
<tr><td>6.5</td><td>npm config rm registry</td></tr>
<tr><td>6.6</td><td>npm cache clean</td></tr>
<tr><td>6.7</td><td>sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm</td></tr>
<tr><td>6.8</td><td>sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm</td></tr>
<tr><td>6.9</td><td>npm config set registry http://registry.npmjs.org</td></tr>
<tr><td>6.10</td><td>npm config set strict-ssl false</td></tr>
<tr><th>7.0:</th><th>VON Network installation - Commands</th></tr>
<tr><td>7.</td><td>apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev</td></tr>
<tr><td>7.</td><td>mkdir -p /home/KOB</td></tr>
<tr><td>7.</td><td>cd /home/KOB</td></tr>
<tr><td>git clone https://github.com/hyperledgerkochi/von-network.git</td></tr>
<tr><td>/home/KOB/von-network/manage rm</td></tr>
<tr><td>/home/KOB/von-network/manage build</td></tr>
<tr><td>/home/KOB/von-network/manage start</td></tr>

</table>

</table>



## Expected Output:

Check (in VirtualMachine) the listed url : http://localhost:9000

Snapshot of expected output:

![](https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/output.JPG)



## Expected Output:
Checkout the expected <a href="https://github.com/EtricKombat/KOBDevOps/wiki/Contact-us-------Contribute-with-us-!">OutPut</a>  


## Alternative Outputs/ Issues & Fix:
*  fatal: unable to access 'https://github.com/bcgov/von-network.git/': Problem with the SSL CA cert  <a href="https://github.com/EtricKombat/KOBDevOps/issues/11">#11</a>
---
# 08- KOB (KochiOrgBook)
<table>
<tr><th>KOB - Build </th><th>KOB - Build playback</th><th>KOB - Startplayback</th></tr>
<tr><td><a href="https://www.youtube.com/watch?v=R5TB-goL3_o&t=51s"><img src="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/KOB-Logo-Dark.jpg.jpeg" width="150"/></a>
</td><td><a href="https://asciinema.org/a/TSpJSfz0azV8vvrR4eN2B7e13"><img src="https://asciinema.org/a/TSpJSfz0azV8vvrR4eN2B7e13.png" width="150"/></a></td><td><a href="https://asciinema.org/a/3oVI9VxseRXHCHLkEx8BR7Edx"><img src="https://asciinema.org/a/3oVI9VxseRXHCHLkEx8BR7Edx.png" width="50"/></a></td></tr>
</table>


<table>
<tr><th>KOB Build - Commands : VON network should be up and running for KOB to work (ref : 07_VON_network steps) </th></tr>
<tr><td>apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev npm</td></tr>
<tr><td>mkdir -p /home/KOB</td></tr>
<tr><td>cd /home/KOB</td></tr>
<tr><td>git clone https://github.com/hyperledgerkochi/TheOrgBook.git</td></tr>
<tr><td>wget https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz</td></tr>
<tr><td>tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz</td></tr>
<tr><td>mv s2i sti /usr/local/bin/</td></tr>
<tr><td>/home/KOB/TheOrgBook/docker/manage rm </td></tr>
<tr><td>/home/KOB/TheOrgBook/docker/manage build</td></tr>
<tr><td>/home/KOB/TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000</td></tr>
</table>




## Expected Output:
Checkout the expected <a href="https://github.com/EtricKombat/KOBDevOps/wiki/Contact-us-------Contribute-with-us-!">OutPut</a>  


## Alternative Outputs/ Issues & Fix:
*  ERROR: for tob_tob-api_1  Cannot start service tob-api: driver failed programming external connectivity on endpoint tob_tob-api_1   <a href="https://github.com/EtricKombat/KOBDevOps/issues/18">#18</a>
* "http://localhost:8080/en/home" not working #854 <a href="https://github.com/bcgov/TheOrgBook/issues/854">#854</a>
*  Bug 19 : "http://localhost:8080/en/home" not working <a href="https://github.com/EtricKombat/KOBDevOps/issues/19">#19</a>

## Expected Output:

Check (in VirtualMachine) the listed url : http://localhost:8080/en/home

Snapshot of expected output:
Snap1
![](https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/TheOrgBook1.JPG)
Snap2
![](https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/TheOrgBook2.JPG)

---


# 09-D-Flow


<table>
<tr><th>D-Flow -Build </th><th>D-Flow -Build playback</th><th>D-Flow -start playback</th></tr>
<tr><td><a href="https://www.youtube.com/watch?v=gSQXq2_j-mw"><img src="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/VON1.gif" width="150"/></a>
</td><td><a href="https://asciinema.org/a/GKTiz7phrerDYcyYUkO26XZhw"><img src="https://asciinema.org/a/GKTiz7phrerDYcyYUkO26XZhw.png" width="50"/></a></td><td><a href="https://asciinema.org/a/aaDjPHA92O5wJlSTPTOd6Xao2"><img src="https://asciinema.org/a/aaDjPHA92O5wJlSTPTOd6Xao2.png" width="150"/></a></td></tr>
</table>
please click on the picture for playback



<table>
<tr><th>Green Light Build - Commands : </th></tr>
<tr><td>apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev npm</td></tr>
<tr><td>mkdir -p /home/KOB</td></tr>
<tr><td>cd /home/KOB</td></tr>
<tr><td>git clone https://github.com/hyperledgerkochi/greenlight.git	</td></tr>
<tr><td>wget https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz</td></tr>
<tr><td>tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz</td></tr>
<tr><td>mv s2i sti /usr/local/bin/</td></tr>
<tr><td>/home/KOB/greenlight/docker/manage rm </td></tr>
<tr><td>/home/KOB/greenlight/docker/manage build </td></tr>
<tr><td>/home/KOB/greenlight/docker/manage start</td></tr>
</table>


---




