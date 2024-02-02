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
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the main process (puma server)
CMD ["rails", "server", "-b", "0.0.0.0"]