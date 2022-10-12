FROM alpine:latest
ENV DOCKERIZE_VERSION v0.6.1



# Update, install bash, postfix, and mailutils, then upgrade
RUN apk add --no-cache --update postfix bash && \
    apk add --no-cache --upgrade mailutils && \
    (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

# Install dockerize
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Copy the postfix config files
COPY postfix-generic /etc/postfix/generic
COPY postfix-main.cf.tmpl /etc/postfix/main.cf.tmpl
COPY sasl-passwd /etc/postfix/sasl-passwd

# Correct permissions for sasl-passwd and generic
RUN chown root:root /etc/postfix/sasl-passwd && chmod 600 /etc/postfix/sasl-passwd && postmap /etc/postfix/sasl-passwd && \
    chown root:root /etc/postfix/generic && chmod 600 /etc/postfix/generic && postmap /etc/postfix/generic

# Copy the entrypoint script to the image
COPY docker-entrypoint.sh /

# Expose the SMTP port
EXPOSE 587
STOPSIGNAL SIGKILL

# Run the entrypoint script
CMD /docker-entrypoint.sh
