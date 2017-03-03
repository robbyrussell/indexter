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
    attr_reader :config_file_path, :exclusions, :suffixes

    DEFAULT_CONFIG_FILE = './.indexter.yaml'.freeze

    def initialize(config_file_path: nil)
      @config_file_path = config_file_path || DEFAULT_CONFIG_FILE
      @exclusions = {}
      @suffixes   = []

      configure if exists?
    end

    def exists?
      File.exists?(config_file_path)
    end

    private

    def configure
      data = YAML.load_stream(File.read(config_file_path))
      return unless data.any?

      data.first.fetch('exclusions', []).each do |hash| 
        @exclusions[hash['table']] = hash.fetch('columns', [])
      end

      @suffixes = data.first.fetch('suffixes', [])
    end

  end
end
