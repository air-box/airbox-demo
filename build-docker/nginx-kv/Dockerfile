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
# get keyless demo
RUN \
  mkdir -p /home/kvdemo && \
  cd /home/kvdemo && \
  git clone https://github.com/air-box/keyless-demo && \
  cd keyless-demo &&\
  chmod +x get.sh
#  ./get.sh requires password

# Expose port
EXPOSE 80

RUN \
  service nginx stop

CMD /usr/sbin/nginx

#CMD ["LD_PRELOAD=~/air-box/keyvisor/keyvisor.so nginx"]
