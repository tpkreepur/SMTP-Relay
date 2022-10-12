#!/bin/bash

# Run dockerize and template file main.cf.tmpl to main.cf
# then run postfix as a child process
dockerize -template /etc/postfix/main.cf.tmpl:/etc/postfix/main.cf postfix start-fg