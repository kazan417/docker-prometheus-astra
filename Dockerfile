FROM registry.astralinux.ru/astra/ubi18
ARG UID=700
ARG GID=700
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r prometheus -g ${GID} && useradd -u ${UID} -c "systemuser for prometheus service" -r -g prometheus prometheus -d /prometheus


RUN apt update; apt install -y prometheus
WORKDIR /prometheus
RUN chown -R prometheus:prometheus /etc/prometheus /prometheus
RUN usermod messagebus -aG prometheus
#RUN chgrp -R 0 /etc/prometheus /prometheus && \
#    chmod -R g=u /etc/prometheus /prometheus

USER prometheus
EXPOSE 9090
VOLUME     [ "/prometheus" ]
CMD [ "/usr/bin/prometheus" ]
