# Spree Stock Status

## Installation

1. Add this extension to your Gemfile with this line:
        
        gem 'spree_stock_status', github: 'mrbrdo/spree_stock_status'

2. Install the gem using Bundler:

        bundle install

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_stock_status:install
  ```
  
4. Restart your server

        If your server was running, restart it so that it can find the assets properly.
