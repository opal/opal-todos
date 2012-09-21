module Vienna
  class Model
    def self.plural_name
      @plural_name ||= "#{name.downcase}s"
    end
  end
end