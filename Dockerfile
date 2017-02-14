FROM docker.io/centos:7

MAINTAINER anthony@atgreen.org

RUN yum -y update
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm && \
    yum install -y https://grafanarel.s3.amazonaws.com/builds/grafana-4.1.2-1486989747.x86_64.rpm && \
    yum install -y git npm /usr/bin/grunt && \
    yum clean all
RUN (mkdir -p /usr/share/grafana/data/plugins && cd /usr/share/grafana/data/plugins && \
     git clone https://github.com/grafana/kairosdb-datasource.git && \
     cd kairosdb-datasource && \
     npm install && \
     grunt)
RUN chown -R grafana:grafana /etc/grafana && chown -R grafana:grafana /usr/share/grafana


EXPOSE 3000

USER root
CMD /usr/sbin/grafana-server \
     --homepath=/usr/share/grafana \
     --config=/etc/grafana/grafana.ini


