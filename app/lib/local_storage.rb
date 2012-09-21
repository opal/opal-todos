module LocalStorage
  class Model < Vienna::Model

    def save
      self.class.sync!
      super
    end

    def to_native
      @attributes.to_native
    end


    def self.create(attrs={})
      model = super(attrs)
      sync!
      model
    end

    def self.destroy(model)
      super(model)
      sync!
    end

    def self.sync!
      data = (@_models || []).map{|m| m.to_native}
      `localStorage[#{@storage_name}] = JSON.stringify(#{data})`
    end

    def self.reset!
      if data = `localStorage[#{@storage_name}] || nil`
        data = JSON.parse(data)
        @_models = data.map { |attrs| new(attrs) }
      else
        @_models = super
      end
    end
  end
end
