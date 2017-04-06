# Bamboo Server

FROM phusion/baseimage:latest
MAINTAINER Mateusz Trojak "matisq@op.pl"
LABEL version="1.0"
LABEL description="JIRA"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Environment
ENV JIRA_VERSION 7.3.4
ENV JIRA_HOME /home/jira
ENV JIRA_SERVER_ID jira-server

# Expose web and agent ports
EXPOSE 8080

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add locales after locale-gen as needed
# Upgrade packages on image
# Install JDK 8 (latest edition), SVN, git  and wget
RUN locale-gen en_US.UTF-8 &&\
    apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y wget --no-install-recommends &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin && rm -f /var/tmp/*

# Setup JAVA 8
ENV JAVA_TOOL_OPTIONS "-Dfile.encoding=UTF8"
ENV JAVA_HOME /opt/jdk1.8.0_111
RUN cd /opt/ &&\
    wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http://www.oracle.com/; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz" &&\
    tar -xzf jdk-8u111-linux-x64.tar.gz &&\
    rm -rf /opt/jdk-8u111-linux-x64.tar.gz

# Setup DB
ADD dbconfig.xml $JIRA_HOME/dbconf.xml

# Add runit service
ADD jira-server.sh /etc/service/jira-server/run
RUN chmod +x /etc/service/jira-server/run
