module Vienna
  class Model

    def self.sync=(sync)
      @sync = sync
    end

    def self.reset!
      @_models = []
      @sync.reset! do |models|
        @_models = models
      end if @sync
    end

    def self.models
      @_models
    end

    def self.plural_name
      @plural_name ||= "#{name.downcase}s"
    end

    def self.create(attrs={})
      model = self.new attrs
      @_models << model
      @sync.create model if @sync
      trigger :create, model
      model
    end

    def self.destroy(model)
      @_models.delete model
      @sync.delete model if @sync
      trigger :destroy, self
    end

    def self.update(model)
      @sync.update model if @sync
      trigger :update, self
    end

    def update
      self.class.update self
      trigger :update
    end

    def self.save(model)
      # .. nothing..
      # @sync.
    end

    def save
      self.class.save self
      super
    end

    def to_json
      @attributes.to_json
    end
  end
end