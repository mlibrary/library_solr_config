class Filter
    def self.registry
        @registry ||= []
    end

    def self.register(candidate)
        registry.prepend(candidate)
    end

    def self.get_filter(name)
        registry.find {|candidate| candidate.handles?(name) }
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

class LCCallNumberFilter < BaseFilter
    Filter.register(self)
    
    def self.handles?(name)
        name == "lc_call_number"
    end

    def solr_class
        "edu.umich.lib.solr_filters.LCCallNumberNormalizerFilterFactory"
    end
end

class ICUFoldingFilter < BaseFilter
    Filter.register(self)

    def self.handles?(name)
        name == "icu_case_folding"
    end

    def solr_class
        "solr.ICUFoldingFilterFactory"
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