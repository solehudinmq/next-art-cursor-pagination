require 'active_support/concern'

module Next
  module Art
    module Cursor
      module Pagination
        module Query
          extend ActiveSupport::Concern

          def self.before(*args)
            puts "BEFORE : #{args}"
          end

          def self.after(*args)
            puts "AFTER : #{args}"
          end
        end
      end
    end
  end
end
