# Bovespa Prices
Bovespa-prices connects to Bovespa to get stock prices

## Installation
Add this line to your application's Gemfile:

```shell
gem 'bovespa-prices'
```

And then execute:
```shell
bundle
```

Or install it yourself as:
```shell
gem install bovespa-prices
```

## Usage

```ruby
require 'bovespa-prices'

bovespa = Bovespa.new

# returns a Hash with Stock objects
results = bovespa.get(:VALE5, :GGBR4)

vale5 = results[:VALE5]
puts vale5.name
puts vale5.opening_price
puts vale5.min_price
puts vale5.max_price
puts vale5.average_price
puts vale5.last_price
puts vale5.variation
puts vale5.code

ggbr4 = results[:GGBR4]
puts ggbr4.name
puts ggbr4.opening_price
puts ggbr4.min_price
puts ggbr4.max_price
puts ggbr4.average_price
puts ggbr4.last_price
puts ggbr4.variation
puts ggbr4.code

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
