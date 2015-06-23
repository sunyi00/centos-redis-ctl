FROM centos:7.1.1503

RUN buildDeps='make gcc gcc-c++ git tar unzip wget'; \
    set -x \
    && yum install -y epel-release \
    && yum install -y $buildDeps \
    && yum install -y python-devel mysql-devel python-pip \
    && pip install pip --upgrade \
    && wget http://influxdb.s3.amazonaws.com/influxdb-0.9.0-1.x86_64.rpm \
    && rpm -ivh influxdb-0.9.0-1.x86_64.rpm \
    && rm -f influxdb-0.9.0-1.x86_64.rpm \
    && yum clean -y all && rm -rf /var/cache/yum/* \
    && cd /root/ \
    && curl -L https://github.com/HunanTV/redis-ctl/archive/master.zip -o redis-ctl.zip \
    && unzip redis-ctl.zip \
    && rm redis-ctl.zip \
    && cd redis-ctl-master/ \
    && pip install -r requirements.txt

EXPOSE 5000
CMD [ "python", "main.py" ]
