ARG RUBY_VERSION=3.1.2
FROM ruby:${RUBY_VERSION}

RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

WORKDIR /usr/src/app

ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
Copy . .

RUN  echo "test 1"
ENTRYPOINT ["/usr/src/app/bin/docker-entrypoint.sh"]
RUN  echo "test 2"


EXPOSE 3000

CMD ["./bin/rails", "server"]
