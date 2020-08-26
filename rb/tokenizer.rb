class Tokenizer
    attr_accessor :solr_class
    def initialize(solr_class=nil)
        @solr_class = solr_class
    end

    def solr_class
        @solr_class || "solr.KeywordTokenizerFactory"
    end

    def to_json
        { "class": solr_class }
    end
end

class PatternTokenizer
    attr_accessor :pattern
    def initialize(pattern)
        @pattern = pattern
    end

    def solr_class
        "solr.PatternTokenizerFactory"
    end

    def to_json
        {
            "class": solr_class,
            "pattern": pattern
        }
    end
end