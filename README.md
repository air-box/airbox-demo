# keyless-demo

This repository containes code to run run keyless functionality proof of concept (PoC) demo and understand integration process in different cloud environments.

The PoC demo uses the following software components in ubunutu 18.04 LTS environment:
* Nginx v1.14
* OpenSSL v1.1

This demo uses Google Cloud and can be easily adapated to any other cloud environments.

## Virtual Machines

### GCE
1. Create a GCE VM instance [GCE Help](https://cloud.google.com/compute/docs/instances/create-start-instance)
2. Clone this repository
```git clone https://github.com/air-box/keyless-demo.git```
3. Fetch pre-requisite
```cd keyless-demo && chmod +x deps.sh && ./deps.sh```
4. Setup Nginx configuration for demo
TODO 

## Docker

## Kubernetes
