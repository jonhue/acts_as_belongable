require 'rails/railtie'

module ActsAsBelongable
    class Railtie < Rails::Railtie

        initializer 'acts_as_belongable.active_record' do
            ActiveSupport.on_load :active_record do
                include ActsAsBelongable::Belonger
                include ActsAsBelongable::Belongable
            end
        end

    end
end
