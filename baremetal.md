# Baremetal keyless demo

## Keyless nginx 
1. Clone keyless-demo
```git clone https://github.com/air-box/keyless-demo.git"

2. Get & build AirBox keyless components
```$ cd keyless-demo```
```$ get.sh```

2. Follow the steps 1-4 & 6 to run & install vanilla nginx (listed below)

3. In place of step 5, run the following:
```$ LD_PRELOAD="~/air-box/keyvisor.so" /usr/sbin/nginx```


## Vanilla nginx w/o daemon mode on ubuntu 18.04 

1. install nginx
```$ sudo apt-get install nginx```

2. Turn off daemon mode. 
Add the following line in /etc/nginx/nginx.conf
```daemon off;```

3. Generate self signed certificates for demo
TODO

4. Configure nginx for demo
Add the following configuration file to /etc/nginx/sites-available/keyless-demo.com

```server {
    listen 443 ssl;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;

    server_name keyless-demo.com www.keyless-demo.com;

    root /home/abadmin/demo-kl/test/static-html;
    index index.html index.htm;

}

server {
    listen 80;
    listen [::]:80;

    server_name keyless-demo.com www.keyless-demo.com;

    return 302 https://$server_name$request_uri;
}```


5. Run nginx

``` $ /usr/sbin/nginx```

6. Test your nginx 

Point your browser to IP of the server to get a response

OR

use command line curl

``` $ curl -k https://<IP address of the server>```

