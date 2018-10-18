FROM fluent/fluentd:v1.2-debian

LABEL maintainer="lixin <1045909037@qq.com>"

COPY entrypoint.sh /bin/entrypoint.sh

RUN buildDeps="make gcc g++ libc-dev ruby-dev build-essential libssl-dev libxml2-dev libxslt1-dev zlib1g-dev" \
    && sed -i 's|//.*.debian.org|//mirrors.ustc.edu.cn|g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
    && gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
    && gem install fluentd-ui && gem sources --clear-all \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENV FLUENTD_OPT="-c /root/.fluentd-ui/fluent.conf -o /root/.fluentd-ui/fluent.log -p /root/.fluentd-ui/plugins"
ENV FLUENTD_UI_PORT="9292"

VOLUME /root/.fluentd-ui

ENTRYPOINT ["/bin/entrypoint.sh"]
