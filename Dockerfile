FROM centos:7
MAINTAINER Vladimir Bueb "vlord@free.fr"
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y localinstall https://labs.consol.de/repo/stable/rhel7/x86_64/labs-consol-stable.rhel7.noarch.rpm
RUN yum -y install naemon
RUN yum -y install nagios-plugins nagios-plugins-all nagios-plugins-nrpe nrpe
RUN yum -y install supervisor
COPY naemon.ini /etc/supervisord.d/naemon.ini
CMD ["/usr/bin/supervisord"]
