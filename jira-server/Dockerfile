# JIRA Server

FROM phusion/baseimage:latest
MAINTAINER Mateusz Trojak "matisq@op.pl"
LABEL version="1.0"
LABEL description="Atlassian JIRA"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Environment
ENV JIRA_VERSION 7.7.0
ENV JIRA_HOME /home/jira
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JIRA_SERVER_ID jira-server
ENV JIRA_JAVA_VERSION 8u162

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
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections &&\
    add-apt-repository ppa:webupd8team/java &&\
    apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y oracle-java8-installer oracle-java8-set-default --no-install-recommends
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin && rm -f /var/tmp/*

# Add runit service
ADD jira-server.sh /etc/service/jira-server/run
RUN chmod +x /etc/service/jira-server/run
