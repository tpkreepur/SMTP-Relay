# POSTFIX-ALPINE Dockerized

---

## Setup

Configure the postfix-generic, postfix-main.cf and sasl-passwd files with your information.

### postfix-generic

Change the *user@domain.com* to match your email account you plan on using to send emails to Office 365.

### postfix-main.cf.tmpl

Change the *mydomain* and *mynetworks* to match your domain and network.
Add your SSL certificate and key to the **secrets** directory if you plan on using TLS.

### sasl-passwd

Add your Office 365 SMTP username and password to the file.

## Build

```bash
cd ./postfix-alpine
docker build -t postfix-alpine .
```

## Run

```bash
docker run -d \
        --rm \
        --init \
        --env POSTFIX_SMTP_HELO_NAME=mail-relay \
        --env POSTFIX_MYORIGIN=mail-relay \
        --env POSTFIX_MYHOSTNAME=mail-relay \
        --hostname mail-relay \
        --name postfix-alpine postfix-alpine \
        --p 8587:587 \
        postfix-alpine:latest
```
