require 'active_support/concern'

module Next
  module Art
    module Cursor
      module Pagination
        module Query
          extend ActiveSupport::Concern

          class_methods do
            def before(*args)
              puts "BEFORE : #{args}"
            end

            def after(*args)
              puts "AFTER : #{args}"
            end
          end
        end
      end
    end
  end
end
