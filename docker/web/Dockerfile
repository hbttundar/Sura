FROM ubuntu:20.04 as web
COPY build/build.sh /tmp/
COPY script/entrypoint.sh /usr/bin/
RUN chmod +x /tmp/build.sh && chmod +x /usr/bin/entrypoint.sh
RUN bash /tmp/build.sh
COPY nginx/  /etc/nginx/
RUN update-ca-certificates
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
#CMD ["/usr/sbin/nginx"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]