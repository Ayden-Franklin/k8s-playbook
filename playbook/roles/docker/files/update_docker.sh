#!/bin/bash
sed -i 's/.*dockerd/& $DOCKER_NETWORK_OPTIONS/g' /usr/lib/systemd/system/docker.service
