FROM tcbweb/wildfly:latest

ENV JBOSS_HOME /opt/tcbweb/wildfly
ENV POSTGRESQL_VERSION 42.2.2

ENV DB_HOST=postgresql
ENV DB_NAME=tcbweb
ENV DB_USER=tcbweb
ENV DB_PASS=tcbweb
ENV WILDFLY_ADMIN_PASSWORD admin

USER root

ADD customization ${JBOSS_HOME}/customization/

RUN cd /tmp && \
  curl --location --output postgresql-${POSTGRESQL_VERSION}.jar --url https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_VERSION}.jar && \
  chown -R tcbweb:tcbweb /opt/tcbweb/ && chown -R tcbweb:tcbweb /tmp

# Expose http and admin ports
EXPOSE 8080 9990

USER tcbweb

# Add the Postgresql datasource and restart the server
ENTRYPOINT ${JBOSS_HOME}/customization/execute.sh