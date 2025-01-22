FROM amd64/ubuntu:24.04

# Задання змінної середовища для часового поясу
ENV TZ=Europe/Kyiv
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y tzdata curl \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && curl -s -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 --output /usr/bin/jq \
    && chmod +x /usr/bin/jq \
    && DM_STABLE=`curl -s https://kasa.vchasno.ua/api/v2/dm/versions | jq -r '.ver.linux.x64'` \
    && curl -s "https://dm-releases.c.prom.st/DeviceManager_${DM_STABLE}.deb" --output /usr/src/dm.deb \
    && (dpkg -i --force-all /usr/src/dm.deb || true) \
    && apt-get clean \
    && rm -f /usr/bin/jq \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && echo "[Server]\nServerPort=3939\nRemoteAccess=1\nLogsPath=/usr/share/edm/Logs/\nUseHttps=0\nCertFile=\nKeyFile=\nKeyPass=" > /usr/share/edm/EDMSrv.ini \
    && echo "\n\n[Database]\nType=\nServer=\nPort=\nDBName=/var/lib/edm/main.s3db\nLogin=\nPass=" >> /usr/share/edm/EDMSrv.ini

CMD ["/usr/share/edm/EDMSrv"]
