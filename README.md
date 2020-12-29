# keyless-demo

This repository containes code to run run keyless functionality proof of concept (PoC) demo and understand integration process in different cloud environments.

The PoC demo uses the following software components in ubunutu 18.04 LTS environment:
* Nginx v1.14
* OpenSSL v1.1

This demo uses Google Compute Engine (GCE) & Google Kubernetes Engine (GKE) environments.

## Running vanilla nginx server vs. keyless nginx server

<span style="background-color: #FFFF00"> vanilla: ```$ nginx``` vs. Keyless nginx: ```$ keyless nginx``` </span>

## Detailed instructions to run demo on GCE VMs

1. [Create](https://cloud.google.com/compute/docs/instances/create-start-instance) and [Connect](https://cloud.google.com/compute/docs/instances/connecting-to-instance) to 2 GCE VM instances
  i) VM for nginx app (nginx-kv)
  ii) VM to run keycentral app (keycentral)
  NOTE: Ensure to set rules for HTTP/HTTPS connections in firewall configuration for both & add rule to accept all traffic on port 4433 on keycentral VM

2. For both your VM instances (using SSH) 
  - clone this repository
  ```$ git clone https://github.com/air-box/keyless-demo.git```
  - Install pre-requisites
  ```$ cd keyless-demo && chmod +x deps.sh && ./deps.sh```

4. From your keycentral VM instance (using SSH), run KeyCentral backend on VM

- Binary:
  ```
  $ mkdir -p ~/air-box/
  $ cp build-docker/keycentral/keycentral ~/air-box
  $ cd ~/air-box && ./keycentral
  ```

- From source: TODO (available on request)

5. From your nginx-kv VM instance, install Keyless on nginx-kv VM

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

- From source: TODO (available on request)

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
  - Test nginx -- From your desktop terminal
  ```$ curl -k https://<nginx-kv VM's external IP address>```
  
6. Run Keyless nginx server
  ```
  $ cd keyless-demo
  $ chmod +x keyless
  $ keyless nginx
  ```

8. Test from your desktop terminal 
```$ curl -k https://<nginx-kv VM's external IP address>```

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

## Detailed instructions to run demo with Docker containers in GCE VMs

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
```$ docker run nginx-kv -p 4433:4433```

  ii) On Keycentral VM:
```$ docker run keycentral -p 4433:4433```

4. Test from your desktop terminal 
```$ curl -k https://<nginx-kv container external IP address>```

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
## Kubernetes
