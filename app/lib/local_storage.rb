module Vienna

  module LocalStorage

    module ClassMethods
      def create!(model)
        sync!
      end

      def destroy!(model)
        sync!
      end

      def update!(model)
        sync!
      end

      def read!(model)
        # ...
      end

      def reset!(&block)
        if data = ::LocalStorage[plural_name]
          @_models = JSON.parse(data).map { |attrs| new(attrs) }
        else
          @_models = []
        end
      end

      def sync!
        ::LocalStorage[plural_name] = @_models.to_json
      end
    end

    def self.included(base)
      base.extend ClassMethods
      base.reset!
    end
  end
end
