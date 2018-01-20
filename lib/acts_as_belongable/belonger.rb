module ActsAsBelongable
    module Belonger

        extend ActiveSuppport::Concern

        module ClassMethods
            def acts_as_belonger
                has_many :belongables, through: :belonger_belongings, source: :belongable
                has_many :belonger_belongings, as: :belonger, dependent: :destroy
            end

            def belonger name, source_type
                has_many name.to_sym, through: :belonger_belongings, source: :belongable, source_type: source_type.to_s
            end
        end

    end
end
