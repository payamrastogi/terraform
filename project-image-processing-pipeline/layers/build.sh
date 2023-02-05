#!/usr/bin/env bash
mkdir -p python
cd python
pip3 install -r ../requirements.txt -t .
cd ..
zip -r layers.zip .