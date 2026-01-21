#/bin/bash

docker build -t ansible_w .
echo "created docker image"
docker compose up -d