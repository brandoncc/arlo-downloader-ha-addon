ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache python3 py3-pip git && \
    git clone https://github.com/diaznet/arlo-downloader /arlo-downloader && \
    cd /arlo-downloader && \
    pip3 install --no-cache-dir --break-system-packages -r requirements.txt && \
    apk del git && \
    rm -rf /var/cache/apk/*

COPY rootfs /

RUN chmod +x /run.sh

CMD ["/run.sh"]
