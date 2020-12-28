FROM ubuntu:18.04

# install nginx
RUN \
  apt-get update && \
  apt-get install -y git && \
  apt-get install -y openssl && \
  apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

#copy nginx conf
COPY nginx.conf /etc/nginx/nginx.conf

#copy sites-enabled
RUN rm -v /etc/nginx/sites-enabled/default
COPY keyless-demo /etc/nginx/sites-enabled/keyless-demo

#Enable use of self-signed certificate
COPY nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY nginx-selfsigned.conf /etc/nginx/snippets/self-signed.conf
COPY nginx-sslparams.conf /etc/nginx/snippets/ssl-params.conf
COPY nginx-dhparam.pem /etc/ssl/certs/dhparam.pem

# get dependencies
RUN \
  apt-get install -y build-essential libssl-dev

# get keyless demo
RUN \
  mkdir -p /home/kvdemo && \
  cd /home/kvdemo && \
  git clone https://github.com/air-box/keyless-demo &&\
  echo "Gotten keyless demo"

#copy keyvisor library
RUN \
  mkdir -p /home/keyvisor && cd /home/keyvisor

COPY keyvisor.so /home/keyvisor/keyvisor.so
COPY keyvisor.conf /home/keyvisor/keyvisor.conf

# Expose port
EXPOSE 80

RUN \
  service nginx stop

#CMD /usr/sbin/nginx

RUN ["chmod", "+x", "/home/kvdemo/keyless-demo/run.sh"]

WORKDIR /home/keyvisor 

ENTRYPOINT /home/kvdemo/keyless-demo/run.sh
