#!/usr/bin/dumb-init /bin/sh

set -e

exec fluentd-ui start --daemonize --port=$FLUENTD_UI_PORT --pidfile=/root/.fluentd-ui/fluent.pid

exec fluentd -qq --suppress-config-dump --suppress-repeated-stacktrace $FLUENTD_OPT
