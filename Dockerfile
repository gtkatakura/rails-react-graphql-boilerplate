FROM ruby:2.7.1-alpine3.12

# App variables
ENV APP_PATH /rails-react-graphql/
ENV APP_USER rails-react-graphql
ENV APP_USER_HOME /home/rails-react-graphql

# Bundler variables
ENV BUNDLE_PATH $APP_USER_HOME
ENV GEM_HOME $APP_USER_HOME/bundle
ENV BUNDLE_BIN $GEM_HOME/bin

# System variables
ENV PATH $PATH:$BUNDLE_BIN

# Puma
EXPOSE 3000

RUN adduser -h $APP_USER_HOME -D $APP_USER

WORKDIR $APP_PATH

COPY Gemfile* package.json yarn.lock $APP_PATH

RUN apk update && apk add --no-cache \
  build-base \
  tzdata \
  nodejs \
  yarn \
  postgresql-dev

RUN bundle install && \
  yarn && \
  chown -R $APP_USER:$APP_USER $APP_USER_HOME && \
  chown -R $APP_USER:$APP_USER $APP_PATH

COPY --chown=rails-react-graphql . $APP_PATH

USER $APP_USER
