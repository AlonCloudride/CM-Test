#!/bin/bash
printf '%s\n' "Check web status"
systemctl status nginx

systemctl status php-fpm
supervisorctl status