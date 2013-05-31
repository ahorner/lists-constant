# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lists_constant/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Horner"]
  gem.email         = ["andrew@tablexi.com"]

  gem.homepage      = "https://github.com/ahorner/lists-constant"
  gem.description   = %q{Easily create localization-friendly constant lists}
  gem.summary       = %q{
    ListsConstant is a module which allows you to easily define
    lists of constant values. I18n is used to translate the listed
    constants into readable values.

    This library is intended to make it simple to keep view-specific
    information (like the text representations of your listed values)
    out of your model classes.
  }

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.name          = "lists_constant"
  gem.require_paths = ["lib"]
  gem.version       = ListsConstant::VERSION

  gem.add_dependency('activesupport')
  gem.add_dependency('i18n')
end
