# Ouroboros

Ouroboros is an experimental implementation of an infinite circular Array. An Array eating it's own tail. 

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ouroboros

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ouroboros

## Motivation

Supporting an application which had rota patterns with a format like D (Day), N (Night), O (Day off), L (Long day). This pattern needed to be allocated to each Junior Doctor in turn `rota[0]` on week 1 through to `rota[19]` on week 20. What became apparant is that this pattern needed to be exploded

```
rota = [
    # Mon  Tue  Wed  Thu  Fri  Sat  Sun
    [ 'L', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 1
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 2
    [ 'D', 'D', 'D', 'D', 'L', 'O', 'O' ], # week 3
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'L' ], # week 4
    [ 'D', 'D', 'D', 'L', 'D', 'O', 'O' ], # week 5
    [ 'D', 'L', 'D', 'D', 'D', 'O', 'O' ], # week 6
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 7
    [ 'N', 'N', 'N', 'N', 'O', 'O', 'O' ], # week 8
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 9
    [ 'D', 'D', 'D', 'D', 'D', 'L', 'O' ], # week 10
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 11
    [ 'D', 'D', 'L', 'D', 'D', 'O', 'O' ], # week 12
    [ 'D', 'D', 'D', 'D', 'N', 'N', 'N' ], # week 13
    [ 'O', 'O', 'D', 'D', 'D', 'O', 'O' ], # week 14
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 15
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 16
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 17
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 18
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ], # week 19
    [ 'D', 'D', 'D', 'D', 'D', 'O', 'O' ]  # week 20
]
```

Into one series of shifts and this pattern could then run in a cycle for 20 weeks, or 52 weeks or even 60 weeks. The pattern just repeats. And then it might even start on the Wednesday so this pattern would have to be rotated.

```
[ 'L', 'D', 'D', 'D', 'D', 'O', 'O', 'D', 'D', 'D', 'D', 'D', 'O', 'O'] # etc.
```

In order to manage these potentially infinite cyclic patterns an `Ouroboros::Array` can be used to simplify accessing shifts for a particular Doctor on day 999 of a recurring pattern.

## Usage

Instantiate an `Ouroboros::Array`

```ruby
[1, 2, 3, 4, 5].to_ouroboros
# or
Ouroboros::Array.new([1, 2, 3, 4, 5])
```

Using the usual suspects `at`

```
o = [1, 2, 3, 4, 5].to_ouroboros
o.at(0)    #=> 1
o.at(5)    #=> 1
o.at(298)  #=> 4
o.at(-218) #=> 3
```

or `[]`

```
o = [1, 2, 3, 4, 5].to_ouroboros

# with index
o[0]    #=> 1
o[5]    #=> 1
o[298]  #=> 4
o[-418] #=> 3

# with index, size
o[1, 12] #=> Ouroboros::Array[2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3]
o[4, 9]  #=> Ouroboros::Array[5, 1, 2, 3, 4, 5, 1, 2, 3]

# with range
o[1..12] #=> Ouroboros::Array[2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3]
o[4..9]  #=> Ouroboros::Array[5, 1, 2, 3, 4, 5]
```

Other `Array` methods are available

```
o = [1, 2, 3, 4, 5].to_ouroboros
o.rotate(2) #=> Ouroboros::Array[3, 4, 5, 1, 2]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/braindeaf/ouroboros.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
