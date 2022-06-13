#!/bin/bash

rm tmp/pids/server.pid

# https://medium.com/@cristian_rivera/cache-rails-bundle-w-docker-compose-45512d952c2d
bundle check || bundle install --binstubs="$BUNDLE_BIN"

# https://medium.com/@admatbandara/how-i-used-docker-with-rails-45601c43ed8f
bundle exec rake db:migrate
if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  bundle exec rake db:setup
  bundle exec rails db:seed
  bundle exec rails elastic:createIndices
fi

# Start the server
bundle exec rails s -b 0.0.0.0 -p $PORT

exec "$@"
