#!/usr/bin/dumb-init /bin/sh

set -e

exec fluentd-ui start --port=$FLUENTD_UI_PORT --pidfile=/fluentd/.fluentd-ui/fluent.pid

exec fluentd --suppress-config-dump --suppress-repeated-stacktrace $FLUENTD_OPT
