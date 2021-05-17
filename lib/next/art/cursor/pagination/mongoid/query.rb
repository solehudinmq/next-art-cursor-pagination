require 'active_support/concern'

module Next
  module Art
    module Cursor
      module Pagination
        module Mongoid
          module Query
            extend ActiveSupport::Concern

            class_methods do
              include Next::Art::Cursor::Pagination::BaseQuery
              
              def before(limit=10, *args)
                valid_params?(limit)
                
                puts "SELF : #{self}"
                puts "LIMIT : #{limit}"
                puts "BEFORE : #{args}"
              end

              def after(limit=10, *args)
                valid_params?(limit)
                
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
end
