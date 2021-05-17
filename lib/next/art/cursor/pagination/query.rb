require 'active_support/concern'

module Next
  module Art
    module Cursor
      module Pagination
        module Query
          extend ActiveSupport::Concern

          class_methods do
            def before(limit:, *args)
              limit ||= 10

              puts "SELF : #{self}"
              puts "LIMIT : #{limit}"
              puts "BEFORE : #{args}"
              self.where
            end

            def after(limit:, *args)
              limit ||= 10

              puts "SELF : #{self}"
              puts "LIMIT : #{limit}"
              puts "AFTER : #{args}"
            end
          end
        end
      end
    end
  end
end
