require_relative 'field_type'

class Tokenizer
    def solr_class
        "solr.KeywordTokenizerFactory"
    end

    def to_json
        { "class": solr_class }
    end
end

class Filter
    def solr_class
        "edu.umich.lib.solr_filters.LCCNNormalizerFilterFactory"
    end

    def to_json
        { "class": solr_class }
    end
end

class Analyzer
    def tokenizer
        Tokenizer.new
    end

    def filter
        Filter.new
    end

    def to_json
        {
            "tokenizer": tokenizer.to_json,
            "filter": filter.to_json
        }
    end
end

class LCCNFieldType
    FieldType.register(self)

    def self.handles?(name)
        name == 'lccn'
    end

    def name
        'lccn'
    end

    def solr_class
        'solr.TextField'
    end

    def analyzer
        Analyzer.new
    end

    def to_json
        {
            "name": name,
            "class": solr_class,
            "analyzer": analyzer.to_json
        }
    end
end