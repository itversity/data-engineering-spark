FROM nginx

RUN apt update && \
  apt install telnet -y && \
  rm -rf /var/lib/apt/lists/* \

RUN rm -rf /etc/nginx/conf.d/default.conf

COPY lmslbserver.conf /etc/nginx/conf.d