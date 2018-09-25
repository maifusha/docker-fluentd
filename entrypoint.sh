#!/usr/bin/dumb-init /bin/sh

set -e

exec fluentd --suppress-config-dump --suppress-repeated-stacktrace $FLUENTD_OPT
