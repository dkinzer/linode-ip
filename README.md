# Linode::Ip

This gem adds the linode-ip executable that takes a match string and returns
the ipv4 address of a linode whose label matches the string.  If there is more
than one match then an interactive session is enabled that allows the user to
pick from a list of matches or to change the matching string.

This gem assumes that the `linode-cli` is available

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linode-ip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linode-ip

## Usage

Example:

```
linode-ip traefik
```

Returns the ip address of the linode labeled  traefik.

Note that the matching string can be a regex.

If more than one match is found, then a session is opened allowing the user to choose between possible matches.

```
> linode-ip qa
Multiple matching linodes found:
-------------------------------
(0) cob-qa-solr-1
(1) qa-tupress-web
(2) ojs3-qa
(3) cob-qa-web
(4) manifold_qa
(5) funcake_qa
(6) aggregator_qa
(7) airflow_qa

[u] Update linode matcher
[e] exit

Choose a lionde or command?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dkinzer/linode-ip. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Linode::Ip project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dkinzer/linode-ip/blob/master/CODE_OF_CONDUCT.md).
