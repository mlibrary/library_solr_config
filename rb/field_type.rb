class FieldType
    def self.registry
        @registry ||= []
    end

    def self.register(candidate)
        registry.prepend(candidate)
    end

    def self.get_type(name)
        registry.find {|candidate| candidate.handles?(name) }.new
    end
end