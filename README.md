# Downloadr
[![Build Status](https://secure.travis-ci.org/claudijd/downloadr.png)](http://travis-ci.org/claudijd/downloadr)

A simple gem to make downloading files in a Ruby application simple without needing to roll your own downloader implementation.

## Installation

Add this line to your application's Gemfile:

    gem 'downloadr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install downloadr

## Usage

		require 'downloadr'
		Downloadr::HTTP.download("http://www.google.com/index.html", "index.html")

## Contributing

1. Fork it ( https://github.com/claudijd/downloadr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
