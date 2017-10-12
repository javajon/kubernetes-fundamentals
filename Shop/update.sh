#!/bin/sh
set -v

kubectl --namespace shop replace --force -f .
