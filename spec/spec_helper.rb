require "bundler/setup"
require "indexter"
require "active_record"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
