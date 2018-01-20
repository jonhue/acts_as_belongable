require 'acts_as_belongable/version'

module ActsAsBelongable

    autoload :Belonger, 'acts_as_belongable/belonger'
    autoload :Belongable, 'acts_as_belongable/belongable'

    require 'acts_as_belongable/railtie'

end
