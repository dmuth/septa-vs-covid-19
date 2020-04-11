#!/bin/bash
#
# Provision our Vagrant instance to run Docker
#


# Errors are fatal
set -e

PACKAGE=$(dpkg -l | grep docker.io || true)

if test "${PACKAGE}"
then
	echo "# Docker is already installed, skipping!"

else
	echo "# Docker not found, installing!"
	apt-get update
	apt-get install -y docker.io
	docker run hello-world
fi


