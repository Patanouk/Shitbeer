## Nginx logs
`systemctl status nginx.service`

## Certificate

Certificate is provided by certbot  
See https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/ for details

Cert is auto-renewed with a daily job  
See the below output

```shell
$ dpkg -L certbot |grep systemd
/lib/systemd
/lib/systemd/system
/lib/systemd/system/certbot.service
/lib/systemd/system/certbot.timer

$ cat /lib/systemd/system/certbot.timer
[Unit]
Description=Run certbot twice daily

[Timer]
OnCalendar=*-*-* 00,12:00:00
RandomizedDelaySec=43200
Persistent=true

[Install]
WantedBy=timers.target

```