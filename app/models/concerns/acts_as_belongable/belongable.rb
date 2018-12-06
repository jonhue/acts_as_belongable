# frozen_string_literal: true

module ActsAsBelongable
  module Belongable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_belongable
        has_many :belongers, through: :belongable_belongings, source: :belonger
        has_many :belongable_belongings, as: :belongable,
                                         class_name: 'Belonging',
                                         dependent: :destroy
      end

      def belongable(name, source_type, options = {})
        if options.key?(:scope)
          belongable_belongings_with_scope(options[:scope])
          through = "belongable_belongings_#{options[:scope]}".to_sym
        end

        has_many name.to_sym, through: through || :belongable_belongings,
                              source: :belonger,
                              source_type: source_type
      end

      def belongable_belongings_with_scope(scope)
        # rubocop:disable Metrics/LineLength
        has_many "belongable_belongings_#{scope}".to_sym, -> { where(scope: scope) }, as: :belongable, class_name: 'Belonging', dependent: :destroy
        # rubocop:enable Metrics/LineLength
      end
    end

    def add_to_belonger(belonger, options = {})
      options[:belonger] = belonger
      belongable_belongings.create(options)
    end

    def add_to_belonger!(belonger, options = {})
      options[:belonger] = belonger
      belongable_belongings.create!(options)
    end

    def create_belonger(klass, options = {})
      belonging_options = options.delete(:belonging) || {}
      object = klass.create(options)
      add_to_belonger(object, belonging_options)
      object
    end

    def create_belonger!(klass, options = {})
      belonging_options = options.delete(:belonging) || {}
      object = klass.create!(options)
      add_to_belonger!(object, belonging_options)
      object
    end

    def belongers_with_scope(scope, source_type: nil)
      return belongable_belongings.where(scope: scope) if source_type.nil?

      belongable_belongings.where(scope: scope, source_type: source_type)
    end
  end
end
