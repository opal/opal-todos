module Vienna
  class Model
    include Eventable
    extend Eventable
    extend Enumerable

    def self.attribute(name)
      string name
    end

    def self.inherited(base)
      base.reset!
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
      create!
      trigger :create, model
      model
    end

    def self.destroy(model)
      @_models.delete model
      destroy!
      trigger :destroy, self
    end

    def self.update(model)
      update!
      trigger :update, self
    end

    def self.save(model)
      # .. nothing..
      # @sync.
    end

    def self.each(&block)
      @_models.each { |m| block.call m }
    end

    def save
      update
      trigger :save
    end

    def update_attribute(name, value)
      @attributes[name] = value
      save
    end

    ##
    # private methods..

    def destroy
      self.class.destroy self
      trigger :destroy
    end

    def update
      self.class.update self
      trigger :update
    end

    def save
      self.class.save self
      update
      trigger :save
    end

    def to_json
      @attributes.to_json
    end
  end
end
