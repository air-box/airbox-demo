# air-box ssh demo

This repository containes code to run run keyless ssh proof of concept (PoC) demo.


The PoC demo uses the following software components:
* Ubunutu 18.04 LTS operating system on host / VMs
* OpenSSH v8.2p1
* OpenSSL v1.1.1f

There are two scenarios covered in this PoC demo:

## Demo Scenario 1
Client accessing a server VM using ssh while client VM has AirBox KeyVisor installed in place of the private ssh key and ssh access is orchestrated via AirBox KeyCentral  

### Detailed steps

1. Create and run 3 Ubuntu 18.04 VMs: (i) client (ii) server and (iii) KeyCentral

2. Check all VMs accept ssh connections and accept all traffic on port 4433

3. On all VMs, setup OpenSSH 

 * check OpenSSH installation
 ```
 $ ssh -V 
 OpenSSH_8.2p1 Ubuntu-4ubuntu0.4, OpenSSL 1.1.1f  31 Mar 2020
 ```

 * Disable password based ssh access
 ```
 $ sed -i -E 's/#?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
 ```
 * check that password access is disabled
 ``` 
 $ cat etc/ssh/sshd_config | grep PasswordAuthentication
 ```

4. On your client and Keycentral VM instance
* clone this repository $ git clone https://github.com/air-box/keyless-demo.git
* Install pre-requisites $ cd keyless-demo && chmod +x deps.sh && ./deps.sh

5. From your keycentral VM instance, run KeyCentral backend on VM
- Binary:
  ```
  $ mkdir -p ~/air-box/
  $ cp build-docker/keycentral/keycentral ~/air-box/keycentral
  $ cp build-docker/keycentral/id_rsa.pub ~/.ssh/id_rsa.pub
  $ cp build-docker/keycentral/id_rsa ~/.ssh/id_rsa
  $ cp build-docker/keycentral/authorized_keys ~/.ssh/authorized_keys
  $ cd ~/air-box && ./keycentral
```
- From source: TODO (available on request)

6. From you client VM, try to ssh on server VM

```ssh <server VM IP>```
This should fail 

## Demo Scenario 2: 
Server VM / machine running ssh server with KeyVisor installed with no public ssh keys authorized to access it and access to the VM is orchestrted through AirBox KeyCentral for a airbox enabled client

1. stop default sshd service on ubuntu

```sudo systemctl disable --now ssh```

2. run 
