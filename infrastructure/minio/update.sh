#!/bin/bash

rm requirements.lock && helm dependency build
helm template demo . | grep -v namespace: > upstream.yaml