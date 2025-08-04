#!/bin/bash

kubectl create namespace kafka || true
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install kafka bitnami/kafka \
  --namespace kafka \
  -f helm-values.yaml
