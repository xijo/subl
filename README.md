# Subl

Provides `subl` command within `irb` or `pry`.

## Installation

Add `require 'subl'` to your `~/.irbrc` or `~/.pryrc`.

## Usage

```ruby
subl "/path/to/file"  # => open the given file path
subl "foo.rb", 23     # => open foo.rb on line 23
subl :rake            # => open gem
subl Foo.method(:bar) # => open source_location of the given method
subl Foo              # => open class/module definition
subl /baz/            # => open method definition of current context
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributions

Thanks @janosch-x for the additions!
