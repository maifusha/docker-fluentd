FROM fluent/fluentd:v1.2-debian

LABEL maintainer="lixin <1045909037@qq.com>"

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev build-essential libssl-dev libxml2-dev libxslt1-dev zlib1g-dev" \
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
    && gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
    && gem install fluentd-ui && gem sources --clear-all \
    && SUDO_FORCE_REMOVE=yes \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN groupadd -g 1000 fluent && useradd -m -u 1000 -g 1000 fluent
USER fluent

ENV FLUENTD_OPT="-c ~/.fluentd-ui/fluent.conf -o ~/.fluentd-ui/fluent.log -p ~/.fluentd-ui/plugins"
ENV FLUENTD_UI_PORT="9292"

VOLUME ~/.fluentd-ui

COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
