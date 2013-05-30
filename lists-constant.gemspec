# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lists_constant/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Horner"]
  gem.email         = ["andrew@tablexi.com"]
  gem.description   = %q{Easily create localization-friendly constant lists}
  gem.summary       = %q{
    ListsConstant supplies a module which allows easy definition of lists of
    constant values for a Ruby class. I18n is used to translate the listed
    constants into readable values.
  }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.name          = "lists-constant"
  gem.require_paths = ["lib"]
  gem.version       = ListsConstant::VERSION

  gem.add_dependency('activesupport')
  gem.add_dependency('i18n')
end
