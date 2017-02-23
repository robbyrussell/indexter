require 'indexter'
require 'rails'

module Indexter
  class Railtie < Rails::Railtie
    railtie_name :indexter

    DEFAULT_FORMATTER = 'pass_fail'

    rake_tasks do
      namespace :indexter do
        desc "Checks the database for missing foreign key indexes"
        task :validate, [:formatter] => :environment do |t, args| 
          puts Indexter::Validator.new(formatter: args[:formatter]).validate
        end
      end

      task indexter: ['indexter:validate']
    end

  end
end
