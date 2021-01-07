FROM ubuntu:18.04

# install nginx
RUN \
  apt-get update && \
  apt-get install -y git && \
  apt-get install -y openssl

# get dependencies
RUN \
  apt-get install -y build-essential libssl-dev

#copy keycentral executable
RUN \
  mkdir -p /home/keycentral

COPY keycentral /home/keycentral/keycentral
COPY cert.pem /home/keycentral/cert.pem
COPY key.pem /home/keycentral/key.pem

# Expose port
EXPOSE 80
EXPOSE 443
EXPOSE 4433

#CMD /usr/sbin/nginx

WORKDIR /home/keycentral 

ENTRYPOINT /home/keycentral/keycentral
