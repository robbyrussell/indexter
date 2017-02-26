require 'rainbow/ext/string'
require 'terminal-table'

module Indexter
  module Formatters
    class Table

      def format(payload)
        missing = payload.fetch(:missing, {})

        rows = missing.inject([]) do |acc, (db_table, columns)|
          acc << [db_table, columns.join("\n")]
          acc << :separator
          acc
        end

        headings = ['Table', 'Column'].map { |col| col.color(:blue).bright }

        Terminal::Table.new(headings: headings, rows: rows).to_s
      end

    end
  end
end
