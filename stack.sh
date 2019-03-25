#!/bin/bash

print() {
  echo -e "\n\\033[48;5;95;38;5;214m$1\\033[0m"
}

local_func() {
  print 'Invoking local function'
  sam local invoke \
    -e payload.json \
    --parameter-overrides ParameterKey=Environment,ParameterValue=dev
}

local_api() {
  print 'Starting local api'
  sam local start-api \
    -p 6000 \
    --parameter-overrides ParameterKey=Environment,ParameterValue=dev
}

package() {
  print 'Starting package'
  sam package \
    --template-file template.yaml \
    --output-template-file package.yaml \
    --s3-bucket hr-sam-workshop
}

validate() {
  print 'Starting validate'
  sam validate \
    --template package.yaml
}

deploy() {
  print 'Starting deploy'
  sam deploy \
    --template-file package.yaml \
    --stack-name KaushikWorkshopStack \
    --capabilities CAPABILITY_IAM
}

deploy_all() {
  package
  validate
  deploy
}

case "$1" in
  local-func) local_func ;;
  local-api) local_api ;;
  package) package ;;
  validate) validate ;;
  deploy) deploy ;;
  deploy-all) deploy_all ;;
  *) echo "$1 (local-func|local-api|package|validate|deploy|deploy-all)"
esac
