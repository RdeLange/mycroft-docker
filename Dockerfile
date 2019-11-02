FROM sassmann/ubuntu-mycroft:latest
RUN sed -i 's/dockerenv/dockerenvnot/g' /opt/mycroft/start-mycroft.sh
