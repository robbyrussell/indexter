<p align='center'>
  <img src='assets/inDexter_logo.jpg' width="600" height="186" alt="inDexter logo" title="inDexter" />
</p>

A gem for discovering foreign key indexes that may be missing from your Rails project.

### Example

Given a Rails table like so:

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

By default, **inDexter** will return a hash:

```
{:suffixes=>["_id", "_uuid"], :exclusions=>["schema_migrations"], :missing=>{"addresses" => ["property_id"]}}
```

which indicated that you that you might want to add an index on table `addresses` for the `property_id` column.

## Installation

1. Add this line to your application's Gemfile:

```ruby
gem 'indexter'
```

2. And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install indexter
```

## Configuration
inDexter is configured via an `.indexter.yaml` file in the root directory of your project (at the same level as your `.gitignore` and `.ruby-version` file). 

Into this file you define the output format, the tables to be excluded from analysis, and the extensions the denote the columns you want to analyze.

If you *don't* have in `.indexter.yaml` file, inDexter will use a set of basic defaults to generate a report. You can then use that to inform the contents of your config file.

### format
The output format the results of the analysis should be displayed in. See **Formatters**, below, for more details.

### exclusions
A list of the tables you *do not* want to analyze.

### suffixes
A list of the column extensions that define which columns should probably be indexed.

### Example

```yaml
format: table
exclusions:
  - table: default_companies
  - table: schema_migrations
  - table: taggings
suffixes:
  - _id
  - _uuid
```

inDexter provides a convenience rake task for viewing your `.indexter.yaml` config file:

```ruby
rake indexter:config
```

## Usage

### Rails Console

```ruby
$ rails c
irb(main):001:0> indexter.validate
=> {:suffixes=>["_id", "_uuid"], :exclusions=>["schema_migrations"], :missing=>{}}
```
In that example the project has no missing indexes.

```ruby
$ rails c
irb(main):001:0> indexter.validate
=> {:suffixes=>["_id", "_uuid"], :exclusions=>["schema_migrations"], :missing=>{"users"=>["active_company_id"]}}
```
In that example the `users` table is missing an index on `active_company_id`.

### Rake Task

```ruby
$ bundle exec rake indexter:validate
{:suffixes=>["_id", "_uuid"], :exclusions=>["schema_migrations"], :missing=>{}}
```
In that example the project has no missing indexes.

```ruby
$ bundle exec rake indexter:validate
{:suffixes=>["_id", "_uuid"], :exclusions=>["schema_migrations"], :missing=>{"users"=>["active_company_id"]}}
```
In that example the `users` table is missing an index on `active_company_id`.

## Formatters

Out of the box, inDexter returns a Ruby hash of the results. But perhaps that's not what you want? Fortunately inDexter also provides a number of additional formatting options:

* `hash`: the default option, returns a Ruby hash
* `json`: renders the output as a JSON string
* `pass_fail`: like a Unix process, returns 0 if no missing index, `n` if missing indexes, where `n` is the number of missing indexes
* `table`: renders the output as an ASCII-art table

## Contributing

Bug reports and pull requests are welcome on GitHub at [Github: inDexter](https://github.com/senorprogrammer/inDexter). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

