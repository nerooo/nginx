![nginx 1.7.11](https://img.shields.io/badge/nginx-1.7.11-brightgreen.svg) ![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

This is a fork of fork of [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

See [rnbwd/spdy](https://github.com/rnbwd/spdy-proxy) for more documentation.

This container has a special [nginx.conf](https://github.com/RnbWd/spdy-proxy/blob/nginx/nginx.conf) file, gzips / caches resources more aggressively, and it also expects the existence of a dhparam in the certs folder linked.

To create a custom dhparam, run this command in the folder linked with the certs:

`openssl dhparam -out dhparam.pem 2048`

Start the container like this:

    $ docker run -d -p 80:80 -p 443:443 -v /path/to/certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock rnbwd/nginx:latest
