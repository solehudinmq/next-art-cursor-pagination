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
              def cursor_pagination(prev_token=nil, next_token=nil, limit=10)
                raise "Limit parameters cannot be negative" if limit.negative?

                if prev_token.nil? && next_token.nil?
                  current_data = self.order(id: :asc).limit(limit)
                  next_data = next_page_data(current_data, limit)

                  result(next_data, data, limit)
                else
                  begin
                    prev_token_value = decrypt_value(prev_token)
                    next_token_value = decrypt_value(next_token)

                    current_data = self.where(prev_token_value.keys.first.gte => prev_token_value.values.first)
                                        .where(next_token_value.keys.first.lte => next_token_value.values.first)
                                        .order(id: :asc).limit(limit)

                    next_data = next_page_data(current_data, limit)

                    result(next_data, data, limit)
                  rescue
                    raise "Invalid token"
                  end
                end
                
                result(prev_token, next_token, data, limit)
              end
            end

            private
              def encrypt_value(value)
                Next::Art::Cursor::Pagination::Encryptor::Token.encrypt(value)
              end

              def decrypt_value(token)
                Next::Art::Cursor::Pagination::Encryptor::Token.decrypt(token)
              end

              def next_page_data(current_data, limit)
                self.where(:id.gt => current_data.last.id).order(id: :asc).limit(limit)
              end

              def links(next_data)
                return {} if next_data.empty?
                
                {
                  prev: encrypt_value({ id: next_data.first.id.to_s }),
                  next: encrypt_value({ id: next_data.last.id.to_s })
                }
              end

              def result(next_data, data, limit)
                {
                  links: links(next_data),
                  data: data,
                  limit: limit
                }
              end
          end
        end
      end
    end
  end
end
