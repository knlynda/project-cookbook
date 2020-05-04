# Project cookbook

[![CircleCI](https://circleci.com/gh/knlynda/project-cookbook.svg?style=svg)](https://circleci.com/gh/knlynda/project-cookbook)

## Development

1. Use ruby `2.7.0`
1. Install dependencies
   ```bash
   gem install bundler
   bunder install
   ```
1. Setup environment by creating `.env` file in the root of the project with the following content:
   ```bash
   CONTENTFUL_API_URL=YOUR_CONTENTFUL_API_URL
   CONTENTFUL_SPACE=YOUR_CONTENTFUL_SPACE
   CONTENTFUL_ENV=YOUR_CONTENTFUL_ENV
   CONTENTFUL_AUTH_TOKEN=YOUR_CONTENTFUL_AUTH_TOKEN
   ```
1. Run app
   ```bash
   bundle exec rails s
   ```

## Testing
1. Run rubocop
   ```bash
   bundle exec rubocop
   ```
1. Run specs
   ```bash
   bundle exec rspec
   ```

## Running in docker
1. Prepare environment
   ```bash
    export RAILS_ENV=production
    export RAILS_SERVE_STATIC_FILES=true
    export RAILS_LOG_TO_STDOUT=true
    export SECRET_KEY_BASE=YOUR_SECRET_KEY_BASE
    export CONTENTFUL_API_URL=YOUR_CONTENTFUL_API_URL
    export CONTENTFUL_SPACE=YOUR_CONTENTFUL_SPACE
    export CONTENTFUL_ENV=YOUR_CONTENTFUL_ENV
    export CONTENTFUL_AUTH_TOKEN=YOUR_CONTENTFUL_AUTH_TOKEN
    ```
1. Build docker image
   ```bash
   docker-compose build
   ```
1. Run app
   ```bash
   docker-compose up
   ```
