module ActsAsBelongable
    module Belonger

        extend ActiveSupport::Concern

        module ClassMethods
            def acts_as_belonger
                has_many :belongables, through: :belonger_belongings, source: :belongable
                has_many :belonger_belongings, as: :belonger, class_name: 'Belonging', dependent: :destroy
            end

            def belonger name, source_type, options = {}
                if options.has_key? :scope
                    belonger_belongings_with_scope options[:scope]
                    through = "belonger_belongings_#{options[:scope]}".to_sym
                end
                through ||= :belonger_belongings
                has_many name.to_sym, through: through, source: :belongable, source_type: source_type.to_s
            end
            def belonger_belongings_with_scope scope
                has_many "belonger_belongings_#{scope}".to_sym, -> { where(scope: scope.to_s) }, as: :belonger, class_name: 'Belonging', dependent: :destroy
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

        def create_belongable _class, options = {}
            belonging_options = options.delete(:belonging) || {}
            object = _class.create options
            self.add_belongable object, belonging_options
            object
        end
        def create_belongable! _class, options = {}
            belonging_options = options.delete(:belonging) || {}
            object = _class.create! options
            self.add_belongable! object, belonging_options
            object
        end

        def belongables_with_scope scope, source_type = nil
            self.belonger_belongings.where(scope: scope.to_s).map { |belonging| source_type.nil? || belonging.belongable.class.name == source_type ? belonging.belongable : nil }.compact
        end

    end
end
