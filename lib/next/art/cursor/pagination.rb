require 'yaml'

require "next/art/cursor/pagination/version"
require "next/art/cursor/pagination/encryptor/token"
require "next/art/cursor/pagination/mongoid"

module Next
  module Art
    module Cursor
      module Pagination
        class Error < StandardError; end
        # Your code goes here...

        YAML.load_file("config/next-art-cursor-pagination.yml").each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
