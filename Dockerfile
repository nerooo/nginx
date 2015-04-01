FROM nginx:1.7.11

MAINTAINER David Wisner dwisner6@gmail.com

ENV DOCKER_HOST unix:///tmp/docker.sock
ENV DOCKER_GEN_VERSION 0.3.9

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Configure Nginx and apply fix for long server names
RUN rm /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx/

 # Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY Procfile /app/
COPY nginx.tmpl /app/

WORKDIR /app/

RUN mkdir cache

VOLUME ["/etc/nginx/certs"]

CMD ["forego", "start", "-r"]

