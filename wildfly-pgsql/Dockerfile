FROM tcbweb/wildfly

MAINTAINER Thorben Brinkmann <thorben@tcbweb.de>

ENV POSTGRESQL_VERSION 42.2.2

ENV DB_HOST=postgresql
ENV DB_NAME=postgresql
ENV DB_USER=postgresql
ENV DB_PASS=postgresql

RUN cd /tmp && \
  curl --location --output postgresql-${POSTGRESQL_VERSION}.jar --url https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_VERSION}.jar && \
  $JBOSS_HOME/bin/jboss-cli.sh --connect --command="deploy /tmp/postgresql-${POSTGRESQL_VERSION}.jar" && \
  $JBOSS_HOME/bin/jboss-cli.sh --connect --command="xa-data-source add --name=campstur --jndi-name=java:/jdbc/datasources/pgsqlDS --user-name=${DB_USER} --password=${DB_PASS} --driver-name=postgresql-${POSTGRESQL_VERSION}.jar --xa-datasource-class=org.postgresql.xa.PGXADataSource --xa-datasource-properties=ServerName=${DB_HOST},PortNumber=5432,DatabaseName=${DB_NAME} --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter" && \
  $JBOSS_HOME/bin/jboss-cli.sh --connect --command=:restart && \
  rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/ $JBOSS_HOME/standalone/log/* && \
  rm -rf /tmp/postgresql-*.jar