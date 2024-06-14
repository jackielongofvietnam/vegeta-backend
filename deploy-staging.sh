#!/bin/bash
docker login;
docker build -t notadev123/vegeta:latest .;
docker push notadev123/vegeta:latest;

ssh -T individual << EOF
  docker pull notadev123/vegeta:latest;
  docker compose -f docker-compose-staging.yml up -d --remove-orphans --force-recreate;
EOF
