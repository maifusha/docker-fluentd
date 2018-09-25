FROM fluent/fluentd:v1.2-debian

LABEL maintainer="lixin <1045909037@qq.com>"

COPY conf/fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/entrypoint.sh

RUN buildDeps="make gcc g++ libc-dev ruby-dev" \
    && apt-get update && apt-get install -y --allow-downgrades --no-install-recommends $buildDeps sudo \
    && gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-elasticsearch \
    && gem install fluent-plugin-secure-forward \
    && gem install fluent-plugin-record-modifier \
    && gem install fluent-plugin-rewrite-tag-filter \
    && gem sources --clear-all \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/lib/ruby/gems/*/cache/*.gem

RUN groupadd -g 1000 fluent && useradd -m -u 1000 -g 1000 fluent \
    && chown -R fluent:fluent /fluentd
USER fluent

VOLUME /fluentd/log ~/.fluentd-ui

ENV FLUENTD_OPT="-qq -c /fluentd/etc/fluent.conf -o /fluentd/log/fluent.log -p /fluentd/plugins"

ENTRYPOINT ["/bin/entrypoint.sh"]
