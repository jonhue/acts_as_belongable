# frozen_string_literal: true

module ActsAsBelongable
  module Belonger
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_belonger
        has_many :belongables, through: :belonger_belongings,
                               source: :belongable
        has_many :belonger_belongings, as: :belonger, class_name: 'Belonging',
                                       dependent: :destroy
      end

      def belonger(name, source_type, options = {})
        if options.key?(:scope)
          belonger_belongings_with_scope(options[:scope])
          through = "belonger_belongings_#{options[:scope]}".to_sym
        end

        has_many name.to_sym, through: through || :belonger_belongings,
                              source: :belongable,
                              source_type: source_type
      end

      def belonger_belongings_with_scope(scope)
        # rubocop:disable Metrics/LineLength
        has_many "belonger_belongings_#{scope}".to_sym, -> { where(scope: scope) }, as: :belonger, class_name: 'Belonging', dependent: :destroy
        # rubocop:enable Metrics/LineLength
      end
    end

    def add_belongable(belongable, options = {})
      options[:belongable] = belongable
      belonger_belongings.create(options)
    end

    def add_belongable!(belongable, options = {})
      options[:belongable] = belongable
      belonger_belongings.create!(options)
    end

    def create_belongable(klass, options = {})
      belonging_options = options.delete(:belonging) || {}
      object = klass.create(options)
      add_belongable(object, belonging_options)
      object
    end

    def create_belongable!(klass, options = {})
      belonging_options = options.delete(:belonging) || {}
      object = klass.create!(options)
      add_belongable!(object, belonging_options)
      object
    end

    def belongables_with_scope(scope, source_type: nil)
      return belonger_belongings.where(scope: scope) if source_type.nil?

      belonger_belongings.where(scope: scope, source_type: source_type)
    end
  end
end
