#!/usr/bin/env bash

set -e # Exit on errors

echo "-> Starting JIRA ..."
echo "   - JIRA_VERSION: ${JIRA_VERSION}"
echo "   - JIRA_HOME:    ${JIRA_HOME}"

mkdir -p $JIRA_HOME

JIRA_DIR=/opt/atlassian-jira-software-${JIRA_VERSION}-standalone

if [ -d ${JIRA_DIR} ]; then
  echo "-> JIRA ${JIRA_VERSION} already found at ${JIRA_DIR}. Skipping download."
else
  JIRA_TARBALL_URL=https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}.tar.gz
  echo "-> Downloading JIRA ${JIRA_VERSION} from ${JIRA_TARBALL_URL} ..."
  wget --progress=dot:mega ${JIRA_TARBALL_URL} -O /tmp/atlassian-jira.tar.gz
  echo "-> Extracting to ${JIRA_DIR} ..."
  tar xzf /tmp/atlassian-jira.tar.gz -C /opt
  rm -f /tmp/atlassian-jira.tar.gz
  echo "-> Installation completed"
fi

# Setup postgress driver
rm -f ${JIRA_DIR}/lib/postgresql-9.1-903.jdbc4-atlassian-hosted.jar
wget --progress=dot:mega https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O ${JIRA_DIR}/lib/postgresql-9.4.1212.jar

# Uncomment to increase Tomcat's maximum heap allocation
# export JAVA_OPTS=-Xmx512M $JAVA_OPTS

echo "-> Running JIRA server ..."
${JIRA_DIR}/bin/catalina.sh run &

# Kill JIRA process on signals from supervisor
trap 'kill $(jobs -p)' SIGINT SIGTERM EXIT

# Wait for JIRA process to terminate
wait $(jobs -p)
