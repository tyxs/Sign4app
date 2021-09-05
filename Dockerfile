FROM ubuntu:18.04

LABEL AUTHOR="none" \
      version=0.0.1

COPY / /scripts

RUN set -ex \
    && apt-get update \
    && apt-get install sudo \
    && sudo apt-get install -y python3-pip \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && sudo apt-get install -y cron \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && sudo apt-get install -y tzdata

WORKDIR /scripts

RUN python3 -m pip install --upgrade pip \
    && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi \
    && chmod 0644 ./cron_list \
    && crontab ./cron_list \
    && touch /var/log/cron.log \
    && apt-get clean

ENTRYPOINT ["/scripts/task_cron.sh"]
