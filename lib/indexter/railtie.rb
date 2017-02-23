require 'indexter'
require 'rails'

module Indexter
  class Railtie < Rails::Railtie
    railtie_name :indexter

    rake_tasks do
      namespace :indexter do
        desc "Checks the database for missing foreign key indexes"
        task :validate, [:formatter] => :environment do |t, args| 
          puts Indexter::Validator.new(formatter: formatter(formatter: args[:formatter])).validate
        end
      end

      task indexter: ['indexter:validate']
    end

    def formatter(formatter: nil)
      formatter  = 'pass_fail' unless formatter
      klass_name = "Indexter::Formatters::#{formatter.to_s.camelize}"
      klass      = klass_name.constantize
    end
  end
end
