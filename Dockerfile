FROM fluent/fluentd:v1.11-1
LABEL name="fluentd"

# Use root account to use apt
USER root

COPY Gemfile* /fluentd/

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev ruby-bigdecimal \
  && gem install bundler \
  && bundle config silence_root_warning true \
  && bundle install --gemfile=/fluentd/Gemfile --path=/fluentd/vendor/bundle \
  && apk del .build-deps \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Copy configuration files
COPY conf/fluent* /fluentd/etc/

# Copy plugins
COPY plugins /fluentd/plugins/

COPY entrypoint.sh /bin/

# Environment variables
ENV FLUENTD_OPT=""
#ENV FLUENTD_CONF="fluent.conf"
ENV LOG_FORMAT="json"

USER fluent
# Overwrite ENTRYPOINT
ENTRYPOINT ["/bin/entrypoint.sh"]
