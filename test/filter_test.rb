require_relative 'test_helper'

class FilterTest < Minitest::Test
    def test_base_filter
        filter = Filter.get_filter.new
        assert_equal filter.to_json, { "class": nil }
    end

    def test_base_filter_with_class
        filter = Filter.get_filter.new("solr.FixBrokenOffsetsFilterFactory")
        assert_equal filter.to_json, {
            "class": "solr.FixBrokenOffsetsFilterFactory"
        }
    end
end