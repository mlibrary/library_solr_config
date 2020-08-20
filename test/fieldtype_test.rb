require_relative 'test_helper'

class FieldTypeTest < Minitest::Test
    def test_primitive_binary
        bin_type = FieldType.get_type('binary')
        assert_equal bin_type.solr_class, "solr.BinaryField"
    end
end