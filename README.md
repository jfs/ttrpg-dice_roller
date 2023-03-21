# TTRPG::DiceRoller

A dice rolling CLI and Ruby library powered by a rich dice notation grammar.

**TTRPG::DiceRoller** supports support two strategies for rolling dice:

- The default is to use Ruby's builtin pseudo-random number generator. If you 
  don't configure **TTRPG::DiceRoller** to use another rolling strategy this is 
  what you'll get. For most uses this is adequate.

- For testing purposes **TTRPG::DiceRoller** also supports getting sequential 
  results from dice rolls. It accomplishes this by tracking the total number of 
  rolls made in an environment variable and using that count to generate the 
  rolled number by dividing total rolls by the sides of the die being rolled 
  and adding 1 to the remainder.

  To activate this strategy set the environment variable `DICE_ROLLER_STRATEGY`
  to `SEQUENCE`. The count of rolls is stored in the environment variable 
  `DICE_ROLLER_SEQUENCE_COUNT` allowing for the sequence to be set to any 
  well-known state during testing.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ttrpg-dice_roller

If bundler is not being used to manage dependencies, install the gem by
executing:

    $ gem install ttrpg-dice_roller

## Usage

**TTRPG::DiceRoller** is intended to be used either from the command line or as 
a Ruby library. It's expected that **TTRPG::DiceRoller** will be used as the 
dice rolling foundation for other TTRPG related tools that want to support the 
same dice rolls that could be done by hand.

### CLI

TODO: Write usage instructions here

### Library

TODO: Write usage instructions here

### Dice Notation Syntax

***WARNING:* Mathematical operator precedence *IS NOT* in effect. All operators 
are treated with equal weight and evaluated from right-to-left. If you are not 
getting the result you expect, group your operations in parentheses to 
prescribe your order of operations.**

TODO: Write usage instructions here

## Development

After checking out the repository, run `bin/setup` to install dependencies. 
Then, run `bin/test` to run the tests. You can also run `bin/console` for an 
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/install`. To release a 
new version, update the version number in `version.rb`, and then run
`bin/release`, which will create a git tag for the version, push git commits 
and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jfs/ttrpg-dice_roller.
