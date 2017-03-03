require 'indexter'
require 'rails'

module Indexter
  class Railtie < Rails::Railtie
    railtie_name :indexter

    rake_tasks do
      namespace :indexter do
        desc "Checks the database for missing foreign key indexes"
        task :validate => :environment do |t, args|
          config = Indexter::Config.new
          puts Indexter::Validator.new(config: config).validate
        end
      end

      task indexter: ['indexter:validate']
    end

  end
end
