module Next
  module Art
    module Cursor
      module Pagination
        module BaseQuery
          def valid_params?(limit)
            raise "The first parameter must be an integer" unless limit.class == Integer

            raise "The first parameter cannot have a negative value" if limit.negative?
          end
        end
      end
    end
  end
end
