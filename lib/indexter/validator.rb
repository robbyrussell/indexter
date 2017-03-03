require 'active_record'

module Indexter
  class Validator
    attr_reader :exclusions, :formatter, :results, :suffixes 

    DEFAULT_FORMATTER  = 'hash'
    DEFAULT_EXCLUSIONS = { 'schema_migrations' => [] }.freeze
    DEFAULT_SUFFIXES   = ['_id', '_uuid'].freeze

    # -------------------- Instance Methods --------------------

    def initialize(config: nil)
      @config = config
      configure
    end

    def validate
      missing = missing_indexes(tables)
      output  = concat_results(missing)

      results = formatter.new.format(output)
    end

    private

      # suffixes are the column endings that indicate which column to search
      # exclusions are lists of tables and columns to not care about
      #
      # Example:
      #   { users: ['account_id', 'other_id'] }
      #
      def configure
        return unless @config

        format      = @config.try(:format)     || DEFAULT_FORMATTER
        @formatter  = find_formatter(format: format)

        @exclusions = @config.try(:exclusions) || DEFAULT_EXCLUSIONS
        @suffixes   = @config.try(:suffixes)   || DEFAULT_SUFFIXES
      end

      def find_formatter(format: nil)
        format     = format || DEFAULT_FORMATTER
        klass_name = "Indexter::Formatters::#{format.to_s.camelize}"
        klass      = klass_name.constantize
      rescue NameError
        # If an un-known formatter is passed here, fall back to the hash
        Indexter::Formatters::Hash
      end

      def missing_indexes(tbls)
        # Check the intersection between what we expect to have indexes on and what we actually have
        # indexes on. If the set is not empty, we might be missing an index
        result = tbls.inject({}) do |acc, table|
          acc[table] = (id_columns(table) - indexes(table))
          acc
        end

        # Reject any tables that have empty results
        result.delete_if { |_, missing| missing.empty? }
      end

      # Returns a list of all the tables in the database that are analysable
      def tables
        if ActiveRecord::Base.connection.respond_to? :data_sources
          ActiveRecord::Base.connection.data_sources - @exclusions.keys
        else
          ActiveRecord::Base.connection.tables - @exclusions.keys
        end
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

      def concat_results(missing)
        {
          suffixes: @suffixes,
          exclusions: @exclusions,
          missing: missing
        }
      end
  end
end
