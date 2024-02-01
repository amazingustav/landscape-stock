# Use the official Ruby image as the base image
FROM ruby:latest

# Optionally set a maintainer label to identify the maintainer of this Dockerfile
LABEL maintainer="gustavoamorim02@gmail.com"

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs

# Set the working directory inside the container
WORKDIR /landscape

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /landscape/Gemfile
COPY Gemfile.lock /landscape/Gemfile.lock

# Install the RubyGems dependencies
RUN bundle install

# Copy the main application into the container
COPY . /landscape

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the main process (puma server)
CMD ["rails", "server", "-b", "0.0.0.0"]



## Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
#ARG RUBY_VERSION=3.3.0
#FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
#
## Rails app lives here
#WORKDIR /rails
#
## Set production environment
#ENV RAILS_ENV="production" \
#    BUNDLE_DEPLOYMENT="1" \
#    BUNDLE_PATH="/usr/local/bundle" \
#    BUNDLE_WITHOUT="development"
#
#
## Throw-away build stage to reduce size of final image
#FROM base as build
#
## Install packages needed to build gems
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y build-essential git libvips pkg-config
#
## Install application gems
#COPY Gemfile Gemfile.lock ./
#RUN bundle install && \
#    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#    bundle exec bootsnap precompile --gemfile
#
## Copy application code
#COPY . .
#
## Precompile bootsnap code for faster boot times
#RUN bundle exec bootsnap precompile app/ lib/
#
#
## Final stage for app image
#FROM base
#
## Install packages needed for deployment
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
#    rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
## Copy built artifacts: gems, application
#COPY --from=build /usr/local/bundle /usr/local/bundle
#COPY --from=build /rails /rails
#
## Run and own only the runtime files as a non-root user for security
#RUN useradd rails --create-home --shell /bin/bash && \
#    chown -R rails:rails db log storage tmp
#USER rails:rails
#
## Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
## Start the server by default, this can be overwritten at runtime
#EXPOSE 3000
#CMD ["./bin/rails", "server"]
