class Filter
    def self.registry
        @registry ||= []
    end

    def self.register(candidate)
        registry.prepend(candidate)
    end

    def self.get_filter(name)
        registry.find {|candidate| candidate.handles?(name) }.new
    end
end

class BaseFilter
    def to_json
        { "class": solr_class }
    end
end

class RemoveDuplicatesFilter < BaseFilter
    Filter.register(self)

    def self.handles?(name)
        name == "remove_duplicates_at_same_position"
    end

    def solr_class
        "solr.RemoveDuplicatesTokenFilterFactory"
    end
end

class ISBNFilter < BaseFilter
    Filter.register(self)

    def self.handles?(name)
        name == "isbn"
    end

    def solr_class
        "edu.umich.lib.solr_filters.ISBNNormalizerFilterFactory"
    end
end

class LCCNFilter < BaseFilter
    Filter.register(self)

    def self.handles?(name)
        name == "lccn"
    end

    def solr_class
        "edu.umich.lib.solr_filters.LCCNNormalizerFilterFactory"
    end
end

class LengthFilter
    Filter.register(self)

    def self.handles?(name)
        name == "length"
    end

    def solr_class
        "solr.LengthFilterFactory"
    end

    def min
        13
    end

    def max
        13
    end

    def to_json
        {
            "class": solr_class,
            "min": min,
            "max": max
        }
    end
end