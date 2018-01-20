module ActsAsBelongable
    module Belongable

        extend ActiveSupport::Concern

        module ClassMethods
            def acts_as_belongable
                has_many :belongers, through: :belongable_belongings, source: :belonger
                has_many :belongable_belongings, as: :belongable, class_name: 'Belonging', dependent: :destroy
            end

            def belongable name, source_type, options = {}
                belongable_belongings_with_scope options[:scope] if options.has_key? :scope
                has_many name.to_sym, through: ( options.has_key? :scope ? "belongable_belongings_#{scope}".to_sym : :belonger_belongings ), source: :belonger, source_type: source_type.to_s
            end
            def belongable_belongings_with_scope scope
                has_many "belongable_belongings_#{scope}".to_sym, -> { where(scope: scope.to_s) }, as: :belongable, class_name: 'Belonging', dependent: :destroy
            end
        end

        def add_to_belonger belonger, options = {}
            options[:belonger] = belonger
            self.belongable_belongings.create options
        end
        def add_to_belonger! belonger, options = {}
            options[:belonger] = belonger
            self.belongable_belongings.create! options
        end

        def create_belonger class_name, options = {}
            belonging_options = options.delete :belonging
            object = class_name.constantize.create options
            self.add_to_belonger object, belonging_options
            object
        end
        def create_belonger! class_name, options = {}
            belonging_options = options.delete :belonging
            object = class_name.constantize.create! options
            self.add_to_belonger! object, belonging_options
            object
        end

        def belongers_with_scope scope, source_type = nil
            self.belongable_belongings.where(scope: scope.to_s).map { |belonging| source_type.nil? || belonging.belonger.class.name == source_type ? belonging.belonger : nil }.compact
        end

    end
end
