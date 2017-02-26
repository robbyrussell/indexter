require 'indexter'
require 'rails'

module Indexter
  class Railtie < Rails::Railtie
    railtie_name :indexter

    rake_tasks do
      namespace :indexter do
        desc "Checks the database for missing foreign key indexes"
        task :validate, [:format] => :environment do |t, args| 
          puts Indexter::Validator.new(format: args[:format]).validate
        end
      end

      task indexter: ['indexter:validate']
    end

  end
end
