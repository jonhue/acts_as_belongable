# acts_as_belongable

[![Gem Version](https://badge.fury.io/rb/acts_as_belongable.svg)](https://badge.fury.io/rb/acts_as_belongable) <img src="https://travis-ci.org/jonhue/acts_as_belongable.svg?branch=master" />

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
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

acts_as_belongable works with Rails 5 onwards. You can add it to your `Gemfile` with:

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
c = Conference.first

# Returns all belongables associated with this record
c.belongables

# Adds a belongable to this record
c.add_belongable Event.first
# c.add_belongable! Event.first

# Creates a belongable record and adds it to this record
c.create_belongable 'Event', options
# c.create_belongable! Event, options
```

### acts_as_belongable

`acts_as_belongable` makes the following methods available:

```ruby
e = Event.first

# Returns all belongers associated with this record
e.belongers

# Adds this record to a belonger
c.add_to_belonger Conference.first
# c.add_to_belonger! Conference.first

# Adds this record to a newly created belonger
c.create_belonger 'Conference', options
# c.create_belonger! Conference, options
```

### acts_as_list

acts_as_belongable integrates with [acts_as_list](). It adds a `position` column to `Belonging`:

```ruby
c.add_belongable Event.first, position: 1
```

### Scopes

You can use scopes to add details to an relation:

```ruby
u = User.first
e = u.create_belongable 'Event'
c = u.create_belongable 'Conference'
u = User.last
u.add_belongable 'Event', scope: 'collaboration'
u.add_belongable 'Conference', scope: 'collaboration'

# Get all belongables with a specific scope
u.belongables_with_scope :collaboration

# Get `Event` belongables with a specific scope
u.belongables_with_scope :collaboration, 'Event'

# Get all belongers with a specific scope
e.belongers_with_scope :collaboration

# Get `User` belongers with a specific scope
e.belongers_with_scope :collaboration, 'User'
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

## To Do

[Here](https://github.com/jonhue/acts_as_belongable/projects/1) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/acts_as_belongable/issues/new).

---

## Contributing

We hope that you will consider contributing to acts_as_belongable. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/acts_as_belongable/graphs/contributors

### Semantic Versioning

acts_as_belongable follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2018 Jonas Hübotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
