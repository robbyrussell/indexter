module Indexter
  module Formatters
    class PassFail

      # Returns like a Unix process:
      #
      # - 0 : successful, no missing indexes
      # - n : failure, returns the number of missing indexes
      #
      def format(payload)
        payload.fetch(:missing, {}).flatten.count
      end

    end
  end
end
