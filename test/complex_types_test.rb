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
                "filter": {
                    "class": "edu.umich.lib.solr_filters.LCCNNormalizerFilterFactory"
                }
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
                    "pattern": "[;,]\s*"
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