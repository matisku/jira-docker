# JIRA Server for Docker
Atlassian JIRA Server.

Set of docker images to install [Atlassian JIRA Server](https://www.atlassian.com/software/jira) based on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).

## Info
This is a [JIRA Stack](https://github.com/matisku/jira-docker). You can download [docker-compose.yml](https://github.com/matisku/jira-docker/blob/master/docker-compose.yml) and check out how it works!

## What's in stack?
`jira-server` - JIRA Server   
`jira-data` - JIRA Volume Storage   
`postgres` - Database Server   
`postgres-data` - Database Volume Storage   

## Bamboo Server
Once stack will start, provide a license. If you are using `docker-compose.yml` from my repository, as a database hostname use `postgres` and for database user and password use `jira`.

## Environment
### JIRA Server:
`JIRA_HOME` - Bamboo home directory. Default: `/home/jira`   
`JIRA_VERSION` - The version to install an run. Default: `7.3.4`   

### Database:
`PGDATA` - Database Storage Folder. Default: `/var/lib/postgresql/data/pgdata`   
`POSTGRES_DB` - Database Name. Default: `jiradb`   
`POSTGRES_USER` - Database User. Default: `jira`   
`POSTGRES_PASSWORD` - Database Password. Default: `jira`   

### Ports:
JIRA Server: `8080`   
Database: `5432`   

## License
Copyright © 2017 Mateusz Trojak. See LICENSE for details.

## Contributors
Any forks are welcome!
