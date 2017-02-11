<p align='center'>
  <img src='assets/inDexter_logo.jpg' width="600" height="186" alt="inDexter logo" title="inDexter" />
</p>

A gem for discovering foreign key indexes that may be missing from your Rails project. **Don't use this yet. It won't work for you.** It's only just begun.


### Example

Given a Rails table like:

```
ActiveRecord::Schema.define do
  create_table :addresses, :force => true do |t|
    t.string :street
    ...
    t.integer :user_id
    t.integer :property_id
  end

  add_index :addresses, :user_id
end
```

inDexter will return a result like this:

```
{ "addresses" => ["property_id"] }
```

which tells you that you might want to add an index on table `addresses` for the `property_id` column. It does not mention the `user_id` column, because that one already has an index.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'indexter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install indexter


## Usage

Don't. Honestly, it's not a great experience yet. You'll just be disappointed.

But if you really, really want to, after loading the gem:

```
$ rails c
irb(main):001:0> Indexter::Validator.new.validate
=> {}
```
In that example the project has no missing indexes.

```
$ rails c
irb(main):001:0> Indexter::Validator.new.validate
=> {"users"=>["active_company_id"]}
```
In that example the `users` table is missing an index on `active_company_id`.


## Contributing

Bug reports and pull requests are welcome on GitHub at [Github: inDexter](https://github.com/senorprogrammer/indexter). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

