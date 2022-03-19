#!/bin/bash

if [[ "$HOSTNAME" =~ -web$ ]]; then
	printf '%s\n' "Check web status"
	systemctl status nginx
else
	printf '%s\n' "Check worker status"
	systemctl status ebankp-worker\@*
fi%