require 'active_record'

module Indexter
  class Validator
    attr_reader :suffixes, :exclusions

    DEFAULT_SUFFIXES   = ['_id', '_uuid'].freeze
    DEFAULT_EXCLUSIONS = ['schema_migrations'].freeze

    def initialize(suffixes = DEFAULT_SUFFIXES, exclusions = DEFAULT_EXCLUSIONS)
      @suffixes   = Array(suffixes)
      @exclusions = Array(exclusions)
    end

    def validate
      # Check the intersection between what we expect to have indexes on and what we actually have
      # indexes on. If the set is not empty, we might be missing an index
      result = tables.inject({}) do |acc, table|
        acc[table] = (id_columns(table) - indexes(table))
        acc
      end

      # Reject any tables that have empty results. We don't care about them, they're not missing indexes
      result.delete_if { |table, missing| missing.empty? }

      # Returns a hash of the results, where the key is the table name, and the value is an array of
      # possibly-missing indexes
      result
    end

    private

      # Returns a list of all the tables in the database (excluding the ones we don't care about)
      def tables
        ActiveRecord::Base.connection.tables - @exclusions
      end

      # These are the columns we expect to have an index on that end in COL_SUFFIX
      def id_columns(table)
        ActiveRecord::Base.connection.columns(table).select do |column|
          column.name.end_with? *@suffixes
        end.map(&:name)
      end

      # These are the columns we have indexes on that also end in COL_SUFFIX
      def indexes(table)
        ActiveRecord::Base.connection.indexes(table).map do |idx_def|
          idx_def.columns.select { |col| col.end_with? *@suffixes }
        end.flatten
      end
  end
end
