require 'indexter/config'
require 'indexter/railtie' if defined?(Rails)
require 'indexter/validator'
require 'indexter/version'

require 'indexter/formatters/hash'
require 'indexter/formatters/json'
require 'indexter/formatters/pass_fail'
require 'indexter/formatters/table'

module Indexter
  extend self

  def validate(config_file_path: Indexter::Config::DEFAULT_CONFIG_FILE, format: 'hash')
    config = Indexter::Config.new(config_file_path: config_file_path)
    obj    = Indexter::Validator.new(config: config, format: format)

    obj.validate
  end
end
