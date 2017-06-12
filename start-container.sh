#!/bin/bash

set -e

if [ $# -gt 1 ]; then
    echo "Allowed arguments to entrypoint are {configserver,services}."
    exit 1
fi

if [ -n "$1" ]; then
    if [ -z "$VESPA_CONFIG_SERVERS" ]; then
        echo "VESPA_CONFIG_SERVERS must be set with '-e VESPA_CONFIG_SERVERS=<comma separated list of config servers>' argument to docker."
        exit 1
    fi
    case $1 in
        configserver)
            echo /opt/vespa/bin/vespa-start-configserver
            ;;
        services)
            echo /opt/vespa/bin/vespa-start-services
            ;;
        *)
            echo "Allowed arguments to entrypoint are {configserver,services}."
            exit 1
            ;;
    esac
else
    echo "export VESPA_CONFIG_SERVERS=$(hostname)"
    echo /opt/vespa/bin/vespa-start-configserver
    echo /opt/vespa/bin/vespa-start-services
fi

tail -f /dev/null
