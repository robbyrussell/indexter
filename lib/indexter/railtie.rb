require 'indexter'
require 'rails'

module Indexter
  class Railtie < Rails::Railtie
    railtie_name :indexter

    rake_tasks do
      namespace :indexter do
        desc "Checks the database for missing foreign key indexes"
        task validate: :environment do
          formatter = Indexter::Formatters::Table
          puts Indexter::Validator.new(formatter: formatter).validate
        end
      end

      task indexter: ['indexter:validate']
    end
  end
end
