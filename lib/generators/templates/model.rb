class Belonging < ApplicationRecord

    belongs_to :belonger, polymorphic: true
    belongs_to :belongable, polymorphic: true

end
