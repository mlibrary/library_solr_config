require_relative 'test_helper'

class ComplexTypesTest < Minitest::Test
    
    def test_lccn_type
        field_type = FieldType.get_type('lccn')
        assert_equal field_type.to_json, {
            "name": "lccn",
            "class": "solr.TextField",
            "analyzer": {
                "tokenizer": {
                    "class": "solr.KeywordTokenizerFactory"
                },
                "filter": [{
                    "class": "edu.umich.lib.solr_filters.LCCNNormalizerFilterFactory"
                }]
            }
        }
    end

    def test_lccn_sortable_type
        field_type = FieldType.get_type("lc_callnumber_sortable")
        assert_equal field_type.to_json, {
            "name": "lc_callnumber_sortable",
            "class": "solr.TextField",
            "analyzer": {
                "tokenizer": {
                    "class": "solr.KeywordTokenizerFactory"
                },
                "filter": [
                    {
                        "class": "solr.PatternReplaceFilterFactory",
                        "pattern": "(?:\\p{Z}+\\p{P}+)|(?:\\p{P}+\\p{Z}+)",
                        "replacement": " ",
                        "replace": "all"
                    },
                    {
                        "class": "edu.umich.lib.solr_filters.LCCallNumberNormalizerFilterFactory"
                    },
                    {
                        "class": "solr.PatternReplaceFilterFactory",
                        "pattern": "^[\\p{P}\\p{Z}]+",
                        "replacement": "",
                        "replace": "all"
                    },
                    {
                        "class": "solr.PatternReplaceFilterFactory",
                        "pattern": "[\\p{P}\\p{Z}]+$",
                        "replacement": "",
                        "replace": "all"
                    },
                    {
                        "class": "solr.PatternReplaceFilterFactory",
                        "pattern": "(?:\\p{Z}+\\p{P}+)|(?:\\p{P}+\\p{Z}+)",
                        "replacement": " ",
                        "replace": "all"
                    },
                    {
                        "class": "solr.ICUFoldingFilterFactory"
                    }
                ]
            }
        }
    end

    def test_isbn_type
        field_type = FieldType.get_type('isbn')
        assert_equal field_type.to_json, {
            "name": "isbn",
            "class": "solr.TextField",
            "analyzer": {
                "tokenizer": {
                    "class": "solr.PatternTokenizerFactory",
                    "pattern": "[;,]\\s*"
                },
                "filter": [
                    { "class": "edu.umich.lib.solr_filters.ISBNNormalizerFilterFactory" },
                    { "class": "solr.RemoveDuplicatesTokenFilterFactory" },
                    {
                        "class": "solr.LengthFilterFactory",
                        "min": 13,
                        "max": 13
                    }
                ]
            }
        }
    end
end