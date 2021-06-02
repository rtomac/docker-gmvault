FROM alpine:3.11

RUN apk add --no-cache bash py2-pip

RUN pip install --no-cache-dir gmvault==1.9.1 crudini==0.9.3

COPY docker-entrypoint.sh gmvault_defaults.conf /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
