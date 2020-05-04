FROM ruby:2.7.0

RUN apt-get update -qq

RUN mkdir /project-cookbook
WORKDIR /project-cookbook
COPY . /project-cookbook

RUN gem install bundler
RUN bundle install

EXPOSE 3000
