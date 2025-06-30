#!/bin/bash
podman system prune -a -f

podman compose --build -d
