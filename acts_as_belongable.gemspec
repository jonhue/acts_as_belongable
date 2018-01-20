# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'acts_as_belongable', 'version'), __FILE__)

Gem::Specification.new do |gem|
    gem.name                  = 'acts_as_belongable'
    gem.version               = ActsAsBelongable::VERSION
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'A Rubygem to add Favorite, Follow, Vote, etc. functionality to ActiveRecord models'
    gem.description           = 'acts_as_belongable is a Rubygem to allow any ActiveRecord model to associate any other model including the option for multiple relationships per association with scopes. You are able to differentiate followers, favorites, watchers, votes and whatever else you can imagine through a single relationship. This is accomplished by a double polymorphic relationship on the Favorite model. There is also built in support for blocking/un-blocking favorite records as well as caching.'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'me@jonhue.me'
    gem.homepage              = 'https://github.com/jonhue/acts_as_belongable'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*']
    gem.require_paths         = ['lib']

    gem.post_install_message  = IO.read('INSTALL.md')

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'railties', '>= 5.0'
    gem.add_dependency 'activesupport', '>= 5.0'
    gem.add_dependency 'activerecord', '>= 5.0'

    gem.add_development_dependency 'sqlite3', '~> 1.3'
    gem.add_development_dependency 'shoulda_create', '~> 0.0'
    gem.add_development_dependency 'shoulda', '~> 3.5'
    gem.add_development_dependency 'factory_girl', '~> 4.8'
    gem.add_development_dependency 'rails', '>= 5.0'
    gem.add_development_dependency 'tzinfo-data', '~> 1.2017'
end
