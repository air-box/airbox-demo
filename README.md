# airbox-demo

This repository containes code to run run keyless functionality proof of concept (PoC) demo and understand integration process in different cloud environments.

The PoC demo uses the following software components in ubunutu 18.04 LTS environment:
* Nginx v1.14
* OpenSSL v1.1

This demo uses Google Compute Engine (GCE) & Google Kubernetes Engine (GKE) environments.

## Deploying vanilla vs. Keyless apps in cloud:

Example: Nginx server w/ daemon mode off invoked from commandline in a VM:

### ```$ nginx``` vs. ```$ keyless nginx``` ###

## Detailed instructions -- GCE VM Demo

1. [Create](https://cloud.google.com/compute/docs/instances/create-start-instance) and [Connect](https://cloud.google.com/compute/docs/instances/connecting-to-instance) to 2 GCE VM instances
  i) VM for nginx app (nginx-kv)
  ii) VM to run keycentral app (keycentral)
  
  NOTE: Ensure rules for HTTP/HTTPS connections in firewall configuration for both & add rule to accept all traffic on port 4433 on keycentral VM

2. For both your VM instances (using SSH) 
  - clone this repository
  ```$ git clone https://github.com/air-box/keyless-demo.git```
  - Install pre-requisites
  ```$ cd keyless-demo && chmod +x deps.sh && ./deps.sh```

4. From your keycentral VM instance (using SSH), run KeyCentral backend on VM

- Binary:
  ```
  $ mkdir -p ~/air-box/
  $ cp build-docker/keycentral/keycentral ~/air-box/keycentral
  $ cp build-docker/keycentral/cert.pem ~/air-box/cert.pem
  $ cp build-docker/keycentral/key.pem ~/air-box/key.pem
  $ cd ~/air-box && ./keycentral
  ```

- From source: TODO (available on request)

5. From your nginx-kv VM instance, install Keyless on nginx-kv VM

- Binary: 
  ```
  $ mkdir -p /opt/air-box/
  $ cp build-docker/nginx-kv/keyvisor.so /opt/air-box/
  $ cp build-docker/nginx-kv/keyvisor.conf /opt/air-box/
  ```
  - Edit keyvisor.conf to set external IP address of your keycentral VM for keyvisor
  ```
  ip:<External IP address of KeyCentral VM>
  port:4433
  ```

- From source: TODO (available on request)

- Setup vanilla nginx on VM. 

You can choose any configuration, certs params to serve a static website etc.  This demo uses the following:

  - Install 
    ```sudo apt-get-install nginx```
    
  - Configure  
    
    1. Turn off daemon mode & turn on http(s) serving
    ```
    $ service nginx stop
    $ cp build-docker/nginx-kv/nginx.conf /etc/nginx/nginx.conf
    ```
    confirm ```daemon off``` at top of the file, erro_log & sites_enabled directives.
    
    2. Add TLS configuration to use self signed certs
    ```
    $ cp build-docker/nginx-kv/nginx-selfsigned.conf /etc/nginx/snippets/self-signed.conf
    $ cp build-docker/nginx-kv/nginx-sslparams.conf /etc/nginx/snippets/ssl-params.conf
    ```
    3. Add self signed certs for demo
    ```
    $ cp build-docker/nginx-kv/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
    $ cp build-docker/nginx-kv/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
    $ cp build-docker/nginx-kv/nginx-dhparam.pem /etc/ssl/certs/dhparam.pem
    ```
    4. Add static demo website
    ```
    $ rm /etc/nginx/sites-enabled/default
    $ cp build-docker/nginx-kv/keyless-demo /etc/nginx/sites-enabled/keyless-demo
    ```
  
  - Check vanilla nginx installation
  ```cp -rf static-html ~/air-box/```
  ```$ nginx ```
  
  - Test nginx -- From your desktop terminal
  ```$ curl -k https://<nginx-kv VM's external IP address>```
  
6. Run Keyless nginx server
  ```
  $ cp keyless-demo/keyless ~/air-box/
  $ cd ~/air-box
  $ chmod +x keyless
  $ sudo ./keyless nginx
  ```

8. Test from your desktop terminal 
```$ curl -k https://<nginx-kv VM's external IP address>```

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

## Detailed instructions -- Docker containers in GCE VMs

1. 1. [Create](https://cloud.google.com/compute/docs/instances/create-start-instance) and [Connect](https://cloud.google.com/compute/docs/instances/connecting-to-instance) to 2 GCE VM instances
  i) VM for nginx app container (nginx-kv)
  ii) VM to run keycentral backend container (keycentral)
  NOTE: Ensure to set rules for HTTP/HTTPS connections in firewall configuration for both & add rule to accept all traffic on port 4433 on keycentral VM

1. Clone repository on both VMs
  ```$ git clone https://github.com/air-box/keyless-demo.git```

2. Build Docker container images:
  i) On nginx-kv VM
    ```
    $ cd keyless-demo/nginx-kv
    $ docker build . -t nginix-kv
    ```

  ii) On Keycentral VM:
    ```
    $ cd keyless-demo/keycentral
    $ docker build
    ```
    
3. Run container:
  i) On nginx-kv VM
```$ docker run --rm --net=host nginx-kv```

  ii) On Keycentral VM:
```$ docker run --rm --net=host keycentral```

4. Test from your desktop terminal 
```$ curl -k https://<nginx-kv IP address of VM running container>```

You should see the following output:
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
## Detailed instructions -- Kubernetes (GKE) managed Docker containers 
