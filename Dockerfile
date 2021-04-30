FROM ruby:3.0.0

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs
RUN apt install -y netcat

LABEL Name=app Version=0.0.1

EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

#ENTRYPOINT ["sh", "./config/docker/startup.sh"]

ADD . /app
