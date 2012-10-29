require 'lib/model'

module Vienna
  module LocalStorage
    def self.included(cls)
      cls.sync = Sync.new(cls)
    end

    class Sync
      def initialize(model)
        @model = model
      end

      def create(model)
        sync!
      end

      def delete(model)
        sync!
      end

      def update(model)
        sync!
      end

      def reset!(&block)
        models = []

        if data = ::LocalStorage[@model.plural_name]
          models = JSON.parse(data).map { |attrs| @model.new(attrs) }
        end

        block.call models
      end

      def sync!
        ::LocalStorage[@model.plural_name] = @model.models.to_json
      end
    end
  end
end
