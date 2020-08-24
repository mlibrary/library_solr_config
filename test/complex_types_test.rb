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
end