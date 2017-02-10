require "indexter"

namespace :indexter do
  desc "Checks the database for missing foreign key indexes"
  task :validate do
    result = Indexter::Validator.new.validate
  end
end
