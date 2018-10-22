#!/usr/bin/dumb-init /bin/sh

set -e

#touch  /root/.fluentd-ui/fluent.conf
#fluentd -qq --suppress-config-dump --suppress-repeated-stacktrace $FLUENTD_OPT

exec fluentd-ui start --port=$FLUENTD_UI_PORT
