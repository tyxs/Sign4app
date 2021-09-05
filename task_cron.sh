#!/bin/sh
set -x

# 保存环境变量，使 cron 运行的 sh 可以访问到 env
env >> /etc/default/locale

service cron restart && echo `date` >> /var/log/cron.log && tail -f /var/log/cron.log && crontab /scripts/cron_list