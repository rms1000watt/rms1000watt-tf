#!/usr/bin/env bash

set -e

export AWS_PROFILE=personal
echo "This script will provision AWS SSM that will be used for deployments.."

configure() {
  echo
  read -rp "Set value: $1 (y/n): " yn

  if [[ $yn != "y" ]]; then
    return
  fi

  if [[ $2 = true ]]; then
    read -srp "$1: " val
    echo
  else
    read -rp "$1: " val
  fi

  aws ssm put-parameter --name "$1" --value "$val" --type String --overwrite
}

configure slack-webhook-url
