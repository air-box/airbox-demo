# keyless-demo on-prem

This repository containes code to run run keyless functionality proof of concept (PoC) demo on an on-prem servers using VMs.

The PoC demo uses the following software components:
* Ubunutu 18.04 LTS operating system on host and VMs
* Nginx v1.14
* OpenSSL v1.1

This demo uses Google Compute Engine (GCE) & Google Kubernetes Engine (GKE) environments.

## Deploying vanilla vs. Keyless apps in cloud:

Example: Nginx server w/ daemon mode off invoked from commandline in a VM:

### ```$ nginx``` vs. ```$ keyless nginx``` ###

## Detailed instructions 

1. Create 2 Ubuntu 18.04 VMs
  i) VM for nginx app (nginx-kv)
  ii) VM to run keycentral app (keycentral)

  
2. Login to your VM instances using terminal 
 
3. Check that both your VMs
  i) accept all HTTP/HTTPS traffic (port 80)  
  ii) accept all traffic on port 4433 on keycentral VM

4. On terminals for both your VM instances  
  - clone this repository
  ```$ git clone https://github.com/air-box/keyless-demo.git```
  - Install pre-requisites
  ```$ cd keyless-demo && chmod +x deps.sh && ./deps.sh```

5. From your keycentral VM instance, run KeyCentral backend on VM

- Binary:
  ```
  $ mkdir -p ~/air-box/
  $ cp build-docker/keycentral/keycentral ~/air-box
  $ cd ~/air-box && ./keycentral
  ```

6. From your nginx-kv VM instance terminal, install Keyless on nginx-kv VM

- Binary: 
  ```
  $ mkdir -p ~/air-box/
  $ cp build-docker/nginx-kv/keyvisor.so ~/air-box/
  $ cp build-docker/nginx-kv/keyvisor.conf ~/air-box/
  ```
  - Edit keyvisor.conf to set external IP address of your keycentral VM for keyvisor
  ```
  ip:<External IP address of KeyCentral VM>
  port:4433
  ```


- Setup vanilla nginx on VM. You can choose any configuration, certs params etc.
Useful tip: For your convinience you can also setup nginx with following provided files on Ubuntu 18.04 LTS
  - Install 
    ```sudo apt-get-install nginx```
  - Configure  
    ```
    $ cp build-docker/nginx-kv/nginx-selfsigned.conf /etc/nginx/snippets/self-signed.conf
    $ cp build-docker/nginx-kv/nginx-sslparams.conf /etc/nginx/snippets/ssl-params.conf
    ```
  - Add self signed certs for demo
    ```
    $ cp build-docker/nginx-kv/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
    $ cp build-docker/nginx-kv/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
    $ cp build-docker/nginx-kv/nginx-dhparam.pem /etc/ssl/certs/dhparam.pem
    ```
  - check vanilla nginx installation
```$ nginx ```
  - Test nginx -- From your host terminal
  ```$ curl -k https://<nginx-kv VM's IP address>```
  
6. Run Keyless nginx server
  ```
  $ cd keyless-demo
  $ chmod +x keyless
  $ keyless nginx
  ```

8. Test from your host terminal 
```$ curl -k https://<nginx-kv VM's IP address>```

In both cases i.e., with vanilla nginx andd nginx with keyless, you should see the same output as below:
```
<html>
  <head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Nginx!</h1>
    <p> Nginx w/ Keyless</p>
</body>
</html>
```