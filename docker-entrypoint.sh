#!/bin/bash

set -e

/usr/sbin/apache2ctl -DFOREGROUND

exec "$@"