FROM nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

#copy nginx conf
COPY nginx.conf /etc/conf/

#copy sites-enabled
COPY keyless-demo /etc/nginx/sites-available/

#create a symlink
RUN ln -s /etc/nginx/sites-enabled/keyless-demo /etc/nginx/sites-available/

#copy self-signed certificate
COPY nginx-selfsigned.crt /etc/ssl/certs/

#copy private key
COPY nginx-selfsigned.key /etc/ssl/private/

# Expose port
EXPOSE 80

CMD ["/usr/sbin/nginx"]

#CMD ["LD_PRELOAD=~/air-box/keyvisor/keyvisor.so nginx"]
