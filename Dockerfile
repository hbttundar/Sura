FROM ubuntu:20.04 as go
WORKDIR /app
# Configure non-root user.
COPY /app ./
ARG PUID
ARG PGID
ARG GOLANG_FILE_NAME
RUN groupadd --force -g $PGID sura
RUN useradd -ms /bin/bash --no-user-group -g $PGID -u $PUID sura
COPY  --chown=sura:root  app  /app/
COPY docker/go/build/build.sh /tmp/build.sh
COPY docker/go/entrypoint.sh /usr/bin/
COPY docker/go/service/goweb.service /lib/systemd/system/goweb.service
RUN chmod +x /tmp/build.sh && chmod +x /usr/bin/entrypoint.sh
RUN bash /tmp/build.sh
RUN bash /usr/bin/entrypoint.sh
EXPOSE 80 443
CMD ["bin/main"]
