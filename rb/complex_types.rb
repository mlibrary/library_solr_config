require_relative 'field_type'
require_relative 'filter'

class Tokenizer
    def solr_class
        "solr.KeywordTokenizerFactory"
    end

    def to_json
        { "class": solr_class }
    end
end

class PatternTokenizer
    def solr_class
        "solr.PatternTokenizerFactory"
    end

    def pattern
        "[;,]\s*"
    end

    def to_json
        {
            "class": solr_class,
            "pattern": pattern
        }
    end
end

class Analyzer
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def tokenizer
        Tokenizer.new
    end

    def filter
        Filter.get_filter(name)
    end

    def to_json
        {
            "tokenizer": tokenizer.to_json,
            "filter": filter.to_json
        }
    end
end

class ISBNAnalyzer < Analyzer
    def tokenizer
        PatternTokenizer.new
    end

    def filter
        [
            Filter.get_filter(name),
            Filter.get_filter('remove_duplicates_at_same_position'),
            Filter.get_filter('length')
        ]
    end

    def to_json
        {
            "tokenizer": tokenizer.to_json,
            "filter": filter.map { |filt| filt.to_json }
        }
    end
end


class ISBNFieldType
    FieldType.register(self)

    def self.handles?(name)
        name == 'isbn'
    end

    def name
        'isbn'
    end

    def solr_class
        'solr.TextField'
    end

    def analyzer
        ISBNAnalyzer.new(name)
    end

    def to_json
        {
            "name": name,
            "class": solr_class,
            "analyzer": analyzer.to_json
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
        Analyzer.new(name)
    end

    def to_json
        {
            "name": name,
            "class": solr_class,
            "analyzer": analyzer.to_json
        }
    end
end