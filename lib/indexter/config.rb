# Indexter::Config
#
# Two ways to provide configuration information:
#
# 1. Pass a path to a YAML file in the constructor
# 2. Create a .indexter.yaml file in the root of the project directory,
#    and Indexter::Config will find it automatically
#
# Note that if you have a .indexter.yaml file _and_ you pass in a file
# path, the file path will trump the default file and over-ride it.
#
require 'yaml'

module Indexter
  class Config
    attr_reader :config_file_path, :format, :exclusions, :suffixes

    DEFAULT_CONFIG_FILE = './.indexter.yaml'.freeze

    def initialize(config_file_path: DEFAULT_CONFIG_FILE)
      @config_file_path = config_file_path
      configure if exists?
    end

    def exists?
      File.exists?(config_file_path)
    end

    def to_yaml
      @data.to_yaml
    end

    private

      def configure
        @data = YAML.load_stream(File.read(config_file_path))
        return unless @data.any?

        load_format(@data)
        load_exclusions(@data)
        load_suffixes(@data)
      end

      def load_format(data)
        @format = data.first.fetch('format', nil)
      end

      def load_exclusions(data)
        @exclusions = data.first.fetch('exclusions', []).inject({}) do |acc, hash| 
          acc[hash['table']] = hash.fetch('columns', [])
          acc
        end
      end

      def load_suffixes(data)
        @suffixes = data.first.fetch('suffixes', [])
      end

  end
end
