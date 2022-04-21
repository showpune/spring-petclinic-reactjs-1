#!/usr/bin/env bash



az cloud set -n AzureCloud
az login
az account set -s "Azure Spring Cloud Dogfood Test v3 - TTL = 1 Days"

# ==== Resource Group ====
export RESOURCE_GROUP=zhiyongli
export REGION=eastus
export SPRING_CLOUD_SERVICE=zhiyongli-asc-e
export APP_NAME=petclinic-reactjs


az configure --defaults \
    group=${RESOURCE_GROUP} \
    location=${REGION} \
    spring-cloud=${SPRING_CLOUD_SERVICE}

# ==== Create the gateway app ====
az spring-cloud app create --name ${APP_NAME} --instance-count 1 --is-public true 

# ==== Deploy apps ====
az spring-cloud app deploy --name ${APP_NAME} --source-path . --service ${SPRING_CLOUD_SERVICE} --resource-group ${RESOURCE_GROUP} --builder nodejs --verbose build_env '{"BP_NODE_RUN_SCRIPTS": "install-types,typings-install"}'
