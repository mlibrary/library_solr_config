require_relative 'test_helper'

class SchemaTest < Minitest::Test
    def test_schema
        output = Schema::build_schema
        assert_equal output, {
            "fieldType": [
                {
                    "name": "isbn",
                    "class": "solr.TextField",
                    "analyzer": {
                        "tokenizer": {
                            "class": "solr.PatternTokenizerFactory",
                            "pattern": "[;,]\\s*"
                        },
                        "filter": [
                            {
                                "class": "edu.umich.lib.solr_filters.ISBNNormalizerFilterFactory"
                            },
                            {
                                "class": "solr.RemoveDuplicatesTokenFilterFactory"
                            },
                            {
                                "class": "solr.LengthFilterFactory",
                                "min": 13,
                                "max": 13
                            }
                        ]
                    }
                },
                {
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
                },
                {
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
                },
            ],
            "field": [],
            "copyField": [],
            "uniqueKey": "id",
            "name": "library_solr_config",
            "version": "1.6"
        }
    end
end