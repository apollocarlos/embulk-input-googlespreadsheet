module Embulk
  module Input
    class Googlespreadsheet < InputPlugin
      module Traceable
        def initialize(e)
          message = "(#{e.class}) #{e}.\n\t#{e.backtrace.join("\t\n")}\n"
          while e.respond_to?(:cause) and e.cause
            # Java Exception cannot follow the JRuby causes.
            message << "Caused by (#{e.cause.class}) #{e.cause}\n\t#{e.cause.backtrace.join("\t\n")}\n"
            e = e.cause
          end

          super(message)
        end
      end

      class ConfigError < ::Embulk::ConfigError
        include Traceable
      end

      class DataError < ::Embulk::DataError
        include Traceable
      end

      class CompatibilityError < DataError; end
      class TypeCastError      < DataError; end
      class UnknownTypeError   < DataError; end
    end
  end
end