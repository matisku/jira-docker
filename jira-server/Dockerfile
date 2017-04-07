# JIRA Server

FROM phusion/baseimage:latest
MAINTAINER Mateusz Trojak "matisq@op.pl"
LABEL version="1.0"
LABEL description="Atlassian JIRA"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Environment
ENV JIRA_VERSION 7.3.4
ENV JIRA_HOME /home/jira
ENV JIRA_SERVER_ID jira-server
ENV JIRA_JAVA_VERSION 8u111

# Expose web and agent ports
EXPOSE 8080

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add locales after locale-gen as needed
# Upgrade packages on image
# Install wget
RUN locale-gen en_US.UTF-8 &&\
    apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y wget --no-install-recommends &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin && rm -f /var/tmp/*

# Install Oracle JAVA 8
ENV JAVA_TOOL_OPTIONS "-Dfile.encoding=UTF8"
ENV JAVA_HOME /opt/jdk-${JIRA_JAVA_VERSION}-linux-x64
RUN cd /opt/ &&\
    wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http://www.oracle.com/; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JIRA_JAVA_VERSION}-b14/jdk-${JIRA_JAVA_VERSION}-linux-x64.tar.gz" &&\
    tar -xzf *.tar.gz &&\
    rm -rf /opt/*.tar.gz &&\
    mv `ls -d jdk*` jdk-${JIRA_JAVA_VERSION}-linux-x64

# Add runit service
ADD jira-server.sh /etc/service/jira-server/run
RUN chmod +x /etc/service/jira-server/run
