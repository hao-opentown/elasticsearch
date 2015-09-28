#!/bin/bash

set -e

# Add elasticsearch as command if needed

# Bash Operation Comment: ${1:0:1} get substring [0,1) of argument $1, arguments start from $0, $@ states for
# all arguments, "set --" to replace arguments with the following string.

if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
if [ "$1" = 'elasticsearch' ]; then
	# Change the ownership of /usr/share/elasticsearch/data to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
	exec gosu elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
