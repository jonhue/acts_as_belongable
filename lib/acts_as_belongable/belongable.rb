module ActsAsBelongable
    module Belongable

        extend ActiveSupport::Concern

        module ClassMethods
            def acts_as_belongable
                has_many :belongers, through: :belongable_belongings, source: :belonger
                has_many :belongable_belongings, as: :belongable, dependent: :destroy
            end

            def belongable name, source_type
                has_many name.to_sym, through: :belongable_belongings, source: :belonger, source_type: source_type.to_s
            end
        end

    end
end
