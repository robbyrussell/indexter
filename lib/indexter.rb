require 'indexter/version'
require 'indexter/validator'
require 'indexter/railtie' if defined?(Rails)

require 'indexter/formatters/json'
require 'indexter/formatters/pass_fail'
require 'indexter/formatters/table'

module Indexter
end
