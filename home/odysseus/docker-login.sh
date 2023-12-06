#!/usr/bin/env bash

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 117604685733.dkr.ecr.eu-west-1.amazonaws.com
