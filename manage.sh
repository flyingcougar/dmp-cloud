#!/usr/bin/bash

CLOUD=''
ACTION=''
AWS_ACCESS_KEY=''
AWS_SECRET_KEY=''

#########################
# The command line help #
#########################
display_help() {
    echo "Usage: $0 {aws|gcp} {start|stop|status}" >&2
    echo
    exit 1
}


function get_cloud {
	case "$1" in
	 "aws"|"gcp")
	  CLOUD=$1
	  get_credentials ${CLOUD}
	  ;;
	 *)
	  echo "Unsupported Cloud"
	  display_help
	  ;;
	esac
}

function get_action() {
	case "$1" in
	 "start"|"stop"|"status")
	  ACTION=$1
	  ;;
	 *)
	  echo "Unsupported Action"
	  display_help
	  ;;
	esac
}

function get_credentials() {
	AWS_ACCESS_KEY=$(cat secured.yml | yq .credentials.aws.access_key -r)
	AWS_SECRET_KEY=$(cat secured.yml | yq .credentials.aws.secret_key -r)
}


get_cloud $1
get_action $2


echo "Working on: ${CLOUD}"
echo "Action: ${ACTION}"


AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY};\
	AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY};\
	AWS_DEFAULT_REGION="eu-central-1";
	terraform apply


#TODO: terraform init
#TODO yq is installed, terraform is installed