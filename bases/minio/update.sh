#!/bin/bash

rm requirements.lock && helm dependency build
helm template kubecon-demo . | grep -v namespace: > upstream.yaml