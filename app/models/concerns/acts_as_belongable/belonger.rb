module ActsAsBelongable
    module Belonger

        extend ActiveSupport::Concern

        module ClassMethods
            def acts_as_belonger
                has_many :belongables, through: :belonger_belongings, source: :belongable
                has_many :belonger_belongings, as: :belonger, class_name: 'Belonging', dependent: :destroy
            end

            def belonger name, source_type
                has_many name.to_sym, through: :belonger_belongings, source: :belongable, source_type: source_type.to_s
            end
        end

        def add_belongable belongable, options = {}
            options[:belongable] = belongable
            self.belonger_belongings.create options
        end
        def add_belongable! belongable, options = {}
            options[:belongable] = belongable
            self.belonger_belongings.create! options
        end

        def create_belongable class_name, options = {}
            belonging_options = options.delete :belonging
            object = class_name.constantize.create options
            self.add_belongable object, belonging_options
        end
        def create_belongable! class_name, options = {}
            belonging_options = options.delete :belonging
            object = class_name.constantize.create! options
            self.add_belongable! object, belonging_options
        end

    end
end
