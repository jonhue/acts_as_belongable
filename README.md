# acts_as_belongable

[![Gem Version](https://badge.fury.io/rb/acts_as_belongable.svg)](https://badge.fury.io/rb/acts_as_belongable) ![Travis](https://travis-ci.org/jonhue/acts_as_belongable.svg?branch=master)

acts_as_belongable is a Rubygem that provides an associations engine for Rails apps. It's primary use case is to simplify `has_many through: ...` relations.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Associations](#associations)
  * [acts_as_belonger](#acts_as_belonger)
  * [acts_as_belongable](#acts_as_belongable)
  * [acts_as_list](#acts_as_list)
  * [Scopes](#scopes)
* [Testing](#testing)
* [To Do](#to-do)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

---

## Installation

acts_as_belongable works with Rails 5.0 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'acts_as_belongable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_belongable

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'acts_as_belongable', github: 'jonhue/acts_as_belongable'
```

Now run the generator:

    $ rails g acts_as_belongable

To wrap things up, migrate the changes into your database:

    $ rails db:migrate

---

## Usage

### Associations

```ruby
class User < ApplicationRecord
  acts_as_belongable
  belongable :attending, 'Event'
end

class Event < ApplicationRecord
  acts_as_belonger
  acts_as_belongable
  belonger :attendees, 'User'
  belongable :conferences, 'Conference'
end

class Conference < ApplicationRecord
  acts_as_belonger
  belonger :events, 'Event'
end
```

### acts_as_belonger

`acts_as_belonger` makes the following methods available:

```ruby
conference = Conference.first

# Returns all belongables associated with this record
conference.belongables

# Adds a belongable to this record
conference.add_belongable(Event.first)
# c.add_belongable! Event.first

# Creates a belongable record and adds it to this record
conference.create_belongable(Event, options)
# c.create_belongable! Event, options
```

### acts_as_belongable

`acts_as_belongable` makes the following methods available:

```ruby
event = Event.first

# Returns all belongers associated with this record
event.belongers

# Adds this record to a belonger
conference.add_to_belonger(Conference.first)
# c.add_to_belonger! Conference.first

# Adds this record to a newly created belonger
conference.create_belonger(Conference, options)
# c.create_belonger! Conference, options
```

### acts_as_list

acts_as_belongable integrates with [acts_as_list](). It adds a `position` column to `Belonging`:

```ruby
conference.add_belongable(Event.first, position: 1)
```

### Scopes

You can use scopes to add details to an relation:

```ruby
user = User.first
event = user.create_belongable(Event)
conference = user.create_belongable(Conference)
user = User.last
user.add_belongable(Event, scope: 'collaboration')
user.add_belongable(Conference, scope: 'collaboration')

# Get all belongables with a specific scope
user.belongables_with_scope(:collaboration)

# Get `Event` belongables with a specific scope
user.belongables_with_scope(:collaboration, belongable_type: 'Event')

# Get all belongers with a specific scope
event.belongers_with_scope(:collaboration)

# Get `User` belongers with a specific scope
event.belongers_with_scope(:collaboration, belonger_type: 'User')
```

You are also able to restrict associations to specific scopes:

```ruby
class User < ApplicationRecord
  acts_as_belonger
  belonger :conference_collaborations, 'Conference', scope: :collaboration
  belonger :conference_attendings, 'Conference', scope: :membership
end

class Conference < ApplicationRecord
  acts_as_belongable
  belongable :collaborators, 'User', scope: :collaboration
  belongable :attendees, 'User', scope: :membership
end
```

---

## Testing

1. Fork this repository
2. Clone your forked git locally
3. Install dependencies

    `$ bundle install`

4. Run specs

    `$ bundle exec rspec`

5. Run RuboCop

    `$ bundle exec rubocop`

---

## To Do

We use [GitHub projects](https://github.com/jonhue/acts_as_belongable/projects/1) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/acts_as_belongable/issues/new).

---

## Contributing

We hope that you will consider contributing to acts_as_belongable. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Semantic Versioning

acts_as_belongable follows Semantic Versioning 2.0 as defined at http://semver.org.
