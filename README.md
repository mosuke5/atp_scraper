[![Build Status](https://travis-ci.org/mosuke5/atp_scraper.svg?branch=master)](https://travis-ci.org/mosuke5/atp_scraper)
# AtpScraper
AtpScraper is a tool scraping tennis data from atpworldtour.com

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

# Get Singles Ranking TOP100
AtpScraper::Get.singles_ranking
# Response Json
# {
#   rannking: "5"
#   player_name: "Rafael Nadal",
#   player_url_name: "rafael-nadal",
#   player_id: "n409",
#   points: "5000"
# }

# Get Singles Ranking 101-200
AtpScraper::Get.singles_ranking("101-200")

# Get Player Activity. For Example Rafael Nadal's activity in 2016
AtpScraper::Get.player_activity("n409", 2016)
# Response Json
# {
#   year: "2016",
#   player_name: "Rafael Nadal",
#   player_rank: "5",
#   opponent_name: "Fernand Verdasco",
#   opponent_rank: "45",
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

## Contributing
- Fork the project.
- Make your feature addition or bug fix, write tests.
- Commit, do not mess with rakefile, version.
- Make a pull request.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

