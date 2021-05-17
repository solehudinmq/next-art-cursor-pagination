require 'active_support/concern'
require 'byebug'

module Next
  module Art
    module Cursor
      module Pagination
        module Mongoid
          module Query
            extend ActiveSupport::Concern

            class_methods do
              def execute(first_token, last_token, limit=10)
                raise "Limit parameters cannot be negative" if limit.is_negative?

                if first_token.nil?
                  self.order(id: :asc).limit(limit)
                else
                  byebug
                end
              end
            end

            private
              def decode_value(token)
                Next::Art::Cursor::Pagination::Encryptor::Token.decrypt(token)
              end
          end
        end
      end
    end
  end
end
