FROM docker.io/centos:7

MAINTAINER anthony@atgreen.org

RUN yum -y update
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm && \
    yum install -y https://grafanarel.s3.amazonaws.com/builds/grafana-3.1.1-1470047149.x86_64.rpm && \
    yum clean all

EXPOSE 80
USER 1001
CMD systemctl start grafana-server

