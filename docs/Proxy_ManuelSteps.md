## Proxy Steps
* You should follow these steps if you are facing issue while proceeding with the <a href="https://github.com/EtricKombat/KOBDevOps/blob




### Numbering Order
* Use 64 bit <a href="https://ubuntu.com/download/desktop/thank-you?version=18.04.3&architecture=amd64">Ubuntu 18.04 ISO</a> Distribution 
* Use <a href="https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe">VirtualBox </a> as Hypervisor


<table>
<tr><th>No: </th><th>Commands</th></tr>
<tr><th>1.0</th><th>If behind proxy server- add below listed proxy config to /etc/apt/apt.conf </th></tr>
<tr><td>1.1</td><td>Acquire::http::proxy "http://username:password@domain.name.com:port/";</td></tr>
<tr><td>1.2</td><td>Acquire::ftp::proxy "ftp://username:password@domain.name.com:port/";</td></tr>
<tr><td>1.3</td><td>Acquire::https::proxy "https://username:password@domain.name.com:port/";</td></tr>
<tr><td>1.4</td><td>Acquire::socks::proxy "socks://username:password@domain.name.com:port/";</td></tr>
<tr><th>2.0</th><th>Exporting Proxy Env variable</th></tr>
<tr><td>2.1</td><td>export http_proxy=http://username:password@domain.name.com:port/</td></tr>
<tr><td>2.2</td><td>export https_proxy=http://username:password@domain.name.com:port/</td></tr>
<tr><td>2.3</td><td>export ftp_proxy=ftp://username:password@domain.name.com:port/</td></tr>
<tr><td>2.4</td><td>export socks_proxy=socks://username:password@domain.name.com:port/</td></tr>
 <tr><th>3.0</th><th>For git, behind proxy server- run the below listed config commands </th></tr>
 <tr><td>3.1</td><td>git config --global http.proxy http://username:password@domain.name.com:port</td></tr>
 <tr><td>3.2</td><td>git config --global https.proxy http://username:password@domain.name.com:port</td></tr>
<tr><th>4.0</th><th>Docker behind proxy </th></tr>
<tr><td>4.1</td><td>mkdir -p /etc/systemd/system/docker.service.d/</td></tr>
<tr><td>4.2</td><td>touch /etc/systemd/system/docker.service.d/https-proxy.conf</td></tr>
<tr><td>4.3</td><td>echo -e "[Service]\nEnvironment="HTTPS_PROXY=http://username:password@domain.name.com:port"">>/etc/systemd/system/docker.service.d/https-proxy.conf </td></tr>
<tr><td>4.4</td><td>rm -rf /root/.docker/config.json</td></tr>
<tr><td>4.5</td><td>docker login</td></tr>
<tr><td>4.6</td><td>sed -i '$ d' /root/.docker/config.json</td></tr>
<tr><td>4.7</td><td>echo -e ",\n "\""proxies"\"": {\n\t "\""default"\"": {\n\t\t "\""httpProxy"\"": "\""http://username:password@domain.name.com:port"\"",\n\t\t "\""httpsProxy"\"": "\""https://username:password@domain.name.com:port"\"",\n\t\t "\""noProxy"\"": "\""localhost,127.0.0.0/8,*.local,host.docker.internal"\"" \n\t\t}\n\t}\n}">>/root/.docker/config.json
</td></tr>

</table>



## Expected Output:
Checkout the expected <a href="https://github.com/EtricKombat/KOBDevOps/wiki/Contact-us-------Contribute-with-us-!">OutPut</a>  


## Alternative Outputs/ Issues & Fix:
*  curl: (35) OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to download.docker.com:443 gpg: no valid OpenPGP data found  <a href="https://github.com/EtricKombat/KOBDevOps/issues/4">#4</a>
*  Could not handshake: The TLS connection was non-properly terminated  <a href="https://github.com/EtricKombat/KOBDevOps/issues/6">#6</a>
*  docker: Error response from daemon: Get https:/registry-1.docker.io/v2/ <a href="https://github.com/EtricKombat/KOBDevOps/issues/7">#7</a>
*  WARNING: Error loading config file: /root/.docker/config.json: unexpected EOF<a href="https://github.com/EtricKombat/KOBDevOps/issues/8">#8</a>
*  No matching distribution found for pyyaml~=5.1.1 (from -r server/requirements.txt (line 1))<a href="https://github.com/EtricKombat/KOBDevOps/issues/9">#9</a>





---


# 06-NPM Installation: 
<table>
<tr><th> NPM Installation - Youtube</th><th>NPM Installation playback</th></tr>
<tr><td><a href="https://www.youtube.com/watch?v=K6QiSKy2zoM&t=468s"><img src="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/NPM.jpeg" width="150"/></a>
</td><td><a href="https://asciinema.org/a/LVgJzmQeVe0meZ3ah0qmICzwO"><img src="https://asciinema.org/a/LVgJzmQeVe0meZ3ah0qmICzwO.png" width="150"/></a></td></tr>
</table>

<table>
<tr><th>NPM - Commands : </th></tr>
<tr><td>npm config rm proxy</td></tr>
<tr><td>npm config rm proxy --global</td></tr>
<tr><td>npm config rm https-proxy</td></tr>
<tr><td>npm config rm https-proxy --global</td></tr>
<tr><td>npm config rm registry</td></tr>
<tr><td>npm cache clean</td></tr>
<tr><td>sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm</td></tr>
<tr><td>sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm</td></tr>
<tr><td>npm config set registry http://registry.npmjs.org</td></tr>
<tr><td>npm config set strict-ssl false</td></tr>
</table>
<table>
<tr><th>NPM - Proxy Commands : </th></tr>
<tr><td>npm config set https-proxy http://${uname}:${pword}@${prox}:${port}--global</td></tr>
<tr><td>npm config set https-proxy http://${uname}:${pword}@${prox}:${port}</td></tr>
<tr><td>npm config set proxy http://${uname}:${pword}@${prox}:${port}--global</td></tr>
<tr><td>npm config set proxy http://${uname}:${pword}@${prox}:${port}</td></tr>

</table>

## Alternative Outputs/ Issues & Fix:
*  npm ERR! code ECONNRESET  <a href="https://github.com/EtricKombat/KOBDevOps/issues/12">#11</a>


---

# 07-VON Network Setting up

<table>
<tr><th>VON Installation </th><th>VON Build - playback</th><th>VON Start playback</th></tr>
<tr><td><a href="https://www.youtube.com/watch?v=g19VNv3DAd0&t=6s"><img src="https://github.com/EtricKombat/KOBDevOps/blob/master/docs/assets/VON-Logo.png" width="150"/></a>
</td><td><a href="https://asciinema.org/a/yP3owPUZyXPfOAutnc0iyPH0s"><img src="https://asciinema.org/a/yP3owPUZyXPfOAutnc0iyPH0s.png" width="50"/></a></td><td><a href="https://asciinema.org/a/fNUJbkWiH5AtalMnfEo5mHDSX"><img src="https://asciinema.org/a/fNUJbkWiH5AtalMnfEo5mHDSX.png" width="150"/></a></td></tr>
</table>


<table>
<tr><th>VON Network Build - Commands : </th></tr>
<tr><td>apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev</td></tr>
<tr><td>mkdir -p /home/KOB</td></tr>
<tr><td>cd /home/KOB</td></tr>
<tr><td>git clone https://github.com/hyperledgerkochi/von-network.git</td></tr>
<tr><td>/home/KOB/von-network/manage rm</td></tr>
<tr><td>/home/KOB/von-network/manage build</td></tr>
<tr><td>/home/KOB/von-network/manage start</td></tr>
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




