require 'spree_stock_status'
require 'rails'

module SpreeStockStatus
  class Railtie < Rails::Railtie
    railtie_name :spree_stock_status

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end