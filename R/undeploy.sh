#!/bin/sh
set -v

kubectl delete deployment,services -l app=r-shiny
