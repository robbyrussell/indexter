require 'json'

module Indexter
  module Formatters
    class Json

      def format(payload)
        payload.to_json
      end

    end
  end
end
