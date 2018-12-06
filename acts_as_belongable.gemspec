# frozen_string_literal: true

require File.expand_path(
  File.join('..', 'lib', 'acts_as_belongable', 'version'),
  __FILE__
)

Gem::Specification.new do |gem|
  gem.name                  = 'acts_as_belongable'
  gem.version               = ActsAsBelongable::VERSION
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Associations engine for Rails'
  gem.description           = 'acts_as_belongable is a Rubygem that provides '\
                              "an associations engine for Rails apps. It's "\
                              'primary use case is to simplify `has_many '\
                              'through: ...` relations.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/acts_as_belongable'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.3'

  gem.add_dependency 'activerecord', '~> 5.2'
  gem.add_dependency 'activesupport', '~> 5.2'
  gem.add_dependency 'acts_as_list', '~> 0.9'
  gem.add_dependency 'railties', '~> 5.2'

  gem.add_development_dependency 'rspec', '~> 3.7'
  gem.add_development_dependency 'rubocop', '~> 0.52'
  gem.add_development_dependency 'rubocop-rspec'
end
