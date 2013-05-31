# ListsConstant

ListsConstant is a module which allows you to easily define
lists of constant values. I18n is used to translate the listed
constants into readable values.

This library is intended to make it simple to keep view-specific
information (like the text representations of your listed values)
out of your model classes.

## Installation

Add this line to your application's Gemfile:

    gem 'lists-constant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lists-constant

## Usage

Example:

In `my_state_machine.rb`:

``` ruby
class MyStateMachine
  include ListsConstant
  lists_constant :first, :second, :third, as: :steps

  attr_accessor :step
  def initialize(step)
    @step = step
  end
end
```

In `locales/en.yml`:

```
en:
  my_state_machine:
    steps:
      first: Initialize
      second: Validate
      third: Save
```

In `locales/es.yml`:

```
es:
  my_state_machine:
    steps:
      first: Inicie
      second: Valide
      third: Guarde
```

Using the generated constant:

``` ruby
MyStateMachine::STEPS
# => [:first, :second, :third]
```

Using class-level localization:

``` ruby
I18n.locale = :en
MyStateMachine.steps[:first]
# => 'Initialize'

MyStateMachine.step_options
# => {
    'Initialize' => :first,
    'Validate' => :second,
    'Save' => :third
  }

I18n.locale = :es
MyStateMachine.steps[:first]
# => 'Inicie'
```

Instance query methods:

``` ruby
msm = MyStateMachine.new(:second)

msm.step_second?
# => true

msm.step_third?
# => false
```

Using instance-level localization:

``` ruby
I18n.locale = :en
msm.localized_step
# => 'Validate'

I18n.locale = :es
msm.localized_step
# => 'Valide'
```

Localization lookups may be scoped by assigning a namespace to
the `ListsConstant` module:

```
en:
  activerecord:
    attributes:
      my_state_machine:
        steps:
...
```

``` ruby
ListsConstant.namespace = 'activerecord.attributes'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
