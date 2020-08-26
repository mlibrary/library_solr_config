class Filter
    def self.registry
        @registry ||= [Filter]
    end

    def self.register(candidate)
        registry.prepend(candidate)
    end

    def self.get_filter(name=nil)
        registry.find {|candidate| candidate.handles?(name) }
    end

    def self.handles?(name)
        true
    end

    attr_accessor :solr_class
    def initialize(solr_class=nil)
        @solr_class = solr_class
    end

    def to_json
        { "class": solr_class }
    end
end

class LCCNFilter < Filter
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

    attr_accessor :min, :max
    def initialize(min, max)
        @min = min
        @max = max
    end

    def solr_class
        "solr.LengthFilterFactory"
    end

    def to_json
        {
            "class": solr_class,
            "min": min,
            "max": max
        }
    end
end

class PatternReplaceFilter
    Filter.register(self)

    def self.handles?(name)
        name == "pattern_replace"
    end

    attr_accessor :pattern, :replacement, :replace
    def initialize(pattern, replacement, replace)
        @pattern = pattern
        @replacement = replacement
        @replace = replace
    end

    def solr_class
        "solr.PatternReplaceFilterFactory"
    end

    def to_json
        {
            "class": solr_class,
            "pattern": pattern,
            "replacement": replacement,
            "replace": replace
        }
    end
end