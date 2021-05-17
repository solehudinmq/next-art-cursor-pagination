# Next::Art::Cursor::Pagination

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/next/art/cursor/pagination`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile ( minimum ruby version is 2.5.0 ):

```ruby
gem 'next-art-cursor-pagination'
```

Or you can do this
```ruby
gem 'next-art-cursor-pagination', git: 'git@github.com:solehudinmq/next-art-cursor-pagination.git', branch: 'master'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install next-art-cursor-pagination

## Usage

First you must create this file:

    $ config/next-art-cursor-pagination.yml

With the following contents:

    $ SECRET_KEY_BASE: "xxxxxxx"
    $ ENCRYPTION_SERVICE_SALT: "xxxxxxx"

You can try the following steps to create a value from the .yml file:

  1. SECRET_KEY_BASE
    
    $ - irb
    $ - require 'active_support'
    $ - SecureRandom.random_bytes(
    $    ActiveSupport::MessageEncryptor.key_len
    $  ) 
  2. ENCRYPTION_SERVICE_SALT

    $ - irb
    $ - require 'securerandom'
    $ - SecureRandom.hex(64)

In the model you have to add this to be able to use the pagination cursor:

  1. Mongoid

    $ include Next::Art::Cursor::Pagination::Mongoid

    Model example for mongoid:

        $ class Post
        $   include Mongoid::Document
        $   include Mongoid::Timestamps
        $   include Next::Art::Cursor::Pagination::Mongoid

        $   field :title, type: String
        $   field :body, type: String
        $   field :position, type: Integer
        $ end


    How to use:

      1.1 Without additional query

        $ posts = Post.cursor_pagination(nil, nil, 2) # this means get data on the first page with a limit of 2
        $ result :
        $ {:links=>{:prev=>"a28VZ4NFug2nF/5ut1/ypZd1oOLEl1HjYxhEBbQg53zXdJMIbLqv/w==--xqjAiKEX0kxfBhx4--u5CZeYjo5or331LGGbM0NA==", :next=>"vBuN2E2BjmTZs6ukm/fho8r786Xb9rjHcyHgKd/4RwsYIci3gpuvxQ==--07uSOjuH51K735ke--JBfVYwrpilsCH5MjwJwBAQ=="}, :data=>[#<Post _id: 60a29282d4ff6a4ace136cc6, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_1", body: "Body_1", position: 1>, #<Post _id: 60a29282d4ff6a4ace136cc7, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_2", body: "Body_2", position: 2>], :limit=>2}

        $ posts = Post.cursor_pagination("a28VZ4NFug2nF/5ut1/ypZd1oOLEl1HjYxhEBbQg53zXdJMIbLqv/w==--xqjAiKEX0kxfBhx4--u5CZeYjo5or331LGGbM0NA==", "vBuN2E2BjmTZs6ukm/fho8r786Xb9rjHcyHgKd/4RwsYIci3gpuvxQ==--07uSOjuH51K735ke--JBfVYwrpilsCH5MjwJwBAQ==", 2) # this means get data on the second page with a limit of 2
        $ result :
        $ {:links=>{:prev=>"vy68BrH54nNQWiPW7svcnK8Py4GItGAOq0Hfp6j8FvqoEKC4RCjA0A==--epmJ3eErZ2ReDy8Q--daLQy0N5qtnLVMTOLR5OsA==", :next=>"In41kGXNHQqLQrQA1ZvGT3P1MPpv63I8mj/w34Tne9OcAJBo4u77pg==--+NOoIgYDREP9ESX6--DUpWn9M0XsNWRDeiqIp8Rg=="}, :data=>[#<Post _id: 60a29282d4ff6a4ace136cc8, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_3", body: "Body_3", position: 3>, #<Post _id: 60a29282d4ff6a4ace136cc9, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_4", body: "Body_4", position: 4>], :limit=>2}

        $ posts = Post.cursor_pagination("U4FP76PxLNImuPGLN5vsjfWtPNwheWMSNrCWHivFDTWYLxTcw9kcCw==--eEBz2DVnM18ukyHc--ykpLSDzSCK21xkb7L6A+7Q==", "IS78jrhi6aErn/u8n4BNsxYmsGC3UFijYXn2av3AlfcgA/VR417m3g==--deUzjDnKOoJ4fmmp--YOwcC4g521KPGltw+j+rgw==", 6) # this means get data on the last page with a limit of 6
        $ result :
        $ {:links=>{}, :data=>[#<Post _id: 60a29282d4ff6a4ace136cca, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_5", body: "Body_5", position: 5>, #<Post _id: 60a29282d4ff6a4ace136ccb, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_6", body: "Body_6", position: 6>, #<Post _id: 60a29282d4ff6a4ace136ccc, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_7", body: "Body_7", position: 7>, #<Post _id: 60a29282d4ff6a4ace136ccd, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_8", body: "Body_8", position: 8>, #<Post _id: 60a29282d4ff6a4ace136cce, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_9", body: "Body_9", position: 9>, #<Post _id: 60a29282d4ff6a4ace136ccf, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_10", body: "Body_10", position: 10>], :limit=>6}

      1.2. With additional query

        $ posts = Post.where(:position.gt=> 3).cursor_pagination(nil, nil, 2) # this means get data on the first page with condition position greather then 3 and a limit of 2
        $ result :
        $ {:links=>{:prev=>"w+T70IoO4bKMOj6XPvMz/Rs0V7Xz0EA4zPeKJN2fsAJ9T32jrHI2FQ==--S2VzcOwQjGw/pAiX--PbWa2n0LOj71niN4cYkVdA==", :next=>"etz6mEVNbqjjq1uZb2GndMrej/Mgl9uNySVd/VnYKR4lNa8l6mOcag==--6iCBtEdxFGY6rIec--jmrfuLVbkQEfodFjrznsgw=="}, :data=>[#<Post _id: 60a29282d4ff6a4ace136cc9, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_4", body: "Body_4", position: 4>, #<Post _id: 60a29282d4ff6a4ace136cca, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_5", body: "Body_5", position: 5>], :limit=>2}

        $ posts = Post.where(:position.gt=> 3).cursor_pagination("LmlfxgPQqxAaGPFq3TG5f6eAmvLcfs4OfieQDfBHaSHeyouVI7Zxvw==--gR5log5w7LlJegtb--rTaSWkVmZoR5xkcX1ZTJrw==", "4W/PKn+cjvS6sUQX3YKzbswNm4u1UGXJ72cCbhdLRCNU7uwKQz1zeA==--DJ1o8cLXk3Owzlf7--H07mNyH5xEEHF2Rlz0gzRg==", 5) # this means get data on the last page with condition position greather then 3 and a limit of 5
        $ result :
        $ {:links=>{}, :data=>[#<Post _id: 60a29282d4ff6a4ace136ccb, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_6", body: "Body_6", position: 6>, #<Post _id: 60a29282d4ff6a4ace136ccc, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_7", body: "Body_7", position: 7>, #<Post _id: 60a29282d4ff6a4ace136ccd, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_8", body: "Body_8", position: 8>, #<Post _id: 60a29282d4ff6a4ace136cce, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_9", body: "Body_9", position: 9>, #<Post _id: 60a29282d4ff6a4ace136ccf, created_at: 2021-05-17 15:57:54 UTC, updated_at: 2021-05-17 18:35:13 UTC, title: "Title_10", body: "Body_10", position: 10>], :limit=>5}

        Note : 
          If the "links" are empty then this means you are on the last page


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/next-art-cursor-pagination. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Next::Art::Cursor::Pagination project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/next-art-cursor-pagination/blob/master/CODE_OF_CONDUCT.md).
