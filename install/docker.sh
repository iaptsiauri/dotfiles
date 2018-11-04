#!/usr/bin/env bash

# needs authentication for the CLI
docker login 

# pulling images
docker pull postgres:9.5
docker pull rabbitmq:3
docker pull rabbitmq:3-management