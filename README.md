# NRQL2Nerd
[![Ruby](https://github.com/aladac/nrql2nerd/actions/workflows/main.yml/badge.svg)](https://github.com/aladac/nrql2nerd/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/nrql2nerd.svg)](https://badge.fury.io/rb/nrql2nerd)

This gem is a very simple lib which allows to directly execute `NRQL` queries on New Relic using the Nerd Graph API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add nrql2nerd

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install nrql2nerd

## Usage
### As a lib

```ruby
NRQL2Nerd.run_query("SELECT * from AjaxRequest where requestUrl like '%api%' LIMIT MAX")

# => [
#  {
#    "appId"=>12345,
#    "message"=>"Some Message"
#    ...
#  }
#]
```
### As a command line tool
```
$ nrql2nerd "SELECT * from AjaxRequest where requestUrl like '%api%' LIMIT MAX"
[
  {
    "appId"=>12345,
    "message"=>"Some Message"
    ...
  }
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aladac/nrql2nerd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/nrql2nerd/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NRQL2Nerd project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/nrql2nerd/blob/main/CODE_OF_CONDUCT.md).
