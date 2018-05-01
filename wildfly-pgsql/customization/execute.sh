#!/bin/sh
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG >/dev/null &

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Setup Datasource"
$JBOSS_CLI -c << EOF
batch

# Add the postgrsql driver module
module add --name=org.postgres --resources=/tmp/postgresql-${POSTGRESQL_VERSION}.jar --dependencies=javax.api,javax.transaction.api

# Add Postgresql driver
/subsystem=datasources/jdbc-driver=postgres:add(driver-name="postgres",driver-module-name="org.postgres",driver-class-name=org.postgresql.Driver)

# Add the datasource
data-source add --name=PostgresDS --driver-name=postgres --jndi-name=java:/PostgresDS --connection-url=jdbc:postgresql://${DB_HOST}:5432/${DB_NAME}?useUnicode=true&amp;characterEncoding=UTF-8 --user-name=${DB_USER} --password=${DB_PASSWORD} --use-ccm=false --max-pool-size=25 --blocking-timeout-wait-millis=5000 --enabled=true

run-batch
EOF

${JBOSS_HOME}/bin/add-user.sh admin ${WILDFLY_ADMIN_PASSWORD}

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi

echo "=> Deploying application"
cp -R ${DEPLOY_DIR}/* ${WILDFLY_DEPLOY_DIR}

echo "-> Starting Wildfly with configuration"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG -b 0.0.0.0 -bmanagement 0.0.0.0