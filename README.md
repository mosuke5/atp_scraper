[![Build Status](https://travis-ci.org/mosuke5/atp_scraper.svg?branch=master)](https://travis-ci.org/mosuke5/atp_scraper)
# AtpScraper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atp_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atp_scraper

## Usage
```ruby
require "atp_scraper"

# Get Singles Ranking
AtpScraper::Ranking.get
# Response Json
# {
#   player_name: "Rafael Nadal",
#   player_url_name: "rafael-nadal",
#   player_id: "n409"
# }

# Get Player Activity. For Example Rafael Nadal's activity in 2016
AtpScraper::Activity.get("n409", 2016)
# Response Json
# {
#   year: 2016,
#   player_name: "Rafael Nadal",
#   player_rank: 5,
#   opponent_name: "Fernand Verdasco",
#   opponent_rank: 45,
#   round: "Round of 128",
#   score: "673 64 63 674 26",
#   win_loss: "L",
#   tournament_name: "Australian Open",
#   tournament_location: "Melbourne, Australia",
#   tournament_start_date: "2016.01.18",
#   tournament_end_date: "2016.01.31",
#   tournament_surface: "OurdoorHard"
# }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
- Fork the project.
- Make your feature addition or bug fix, write tests.
- Commit, do not mess with rakefile, version.
- Make a pull request.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

