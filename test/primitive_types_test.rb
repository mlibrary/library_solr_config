require_relative 'test_helper'

class PrimitiveTypesTest < Minitest::Test
    def test_primitive_binary
        bin_type = FieldType.get_type('binary')
        assert_equal bin_type.to_json, {
            "class": "solr.BinaryField",
            "name": "binary"
        }.to_json
    end

    def test_primitive_bool
        bin_type = FieldType.get_type('boolean')
        assert_equal bin_type.to_json, {
            "class": "solr.BoolField",
            "name": "boolean",
            "sortMissingLast": true
        }.to_json
    end

    def test_primitive_date
        bin_type = FieldType.get_type('date')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieDateField",
            "name": "date",
            "precisionStep": 0,
            "positionIncrementGap": 0
        }.to_json
    end

    def test_primitive_double
        bin_type = FieldType.get_type('double')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieDoubleField",
            "name": "double",
            "precisionStep": 0,
            "positionIncrementGap": 0
        }.to_json
    end

    def test_primitive_float
        bin_type = FieldType.get_type('float')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieFloatField",
            "name": "float",
            "precisionStep": 0,
            "positionIncrementGap": 0
        }.to_json
    end

    def test_primitive_int
        bin_type = FieldType.get_type('int')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieIntField",
            "name": "int",
            "precisionStep": 0,
            "positionIncrementGap": 0,
            "docValues": true
        }.to_json
    end

    def test_primitive_long
        bin_type = FieldType.get_type('long')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieLongField",
            "name": "long",
            "precisionStep": 0,
            "positionIncrementGap": 0,
            "docValues": true
        }.to_json
    end

    def test_primitive_string
        bin_type = FieldType.get_type('string')
        assert_equal bin_type.to_json, {
            "class": "solr.StrField",
            "name": "string",
            "stored": false,
            "indexed": false,
            "multiValued": false,
            "docValues": true
        }.to_json
    end

    def test_primitive_facet
        bin_type = FieldType.get_type('facet')
        assert_equal bin_type.to_json, {
            "class": "solr.StrField",
            "name": "facet",
            "stored": false,
            "indexed": true,
            "multiValued": true,
            "docValues": true
        }.to_json
    end

    def test_primitive_single_date_stored
        bin_type = FieldType.get_type('single_date_stored')
        assert_equal bin_type.to_json, {
            "class": "solr.TrieDateField",
            "name": "single_date_stored",
            "stored": false,
            "indexed": false,
            "multiValued": false,
            "docValues": true
        }.to_json
    end

    def test_primitive_ignored
        bin_type = FieldType.get_type('ignored')
        assert_equal bin_type.to_json, {
            "class": "solr.StrField",
            "name": "ignored",
            "stored": false,
            "indexed": false,
            "multiValued": true
        }.to_json
    end

    def test_primitive_location_rpt
        bin_type = FieldType.get_type('location_rpt')
        assert_equal bin_type.to_json, {
            "class": "solr.SpatialRecursivePrefixTreeFieldType",
            "name": "location_rpt",
            "geo": true,
            "distErrPct": 0.025,
            "maxDistErr": 0.000009,
            "distanceUnits": "degrees"
        }.to_json
    end

    def test_primitive_point
        bin_type = FieldType.get_type('point')
        assert_equal bin_type.to_json, {
            "class": "solr.PointType",
            "name": "point",
            "dimension": 2,
            "subFieldSuffix": "d"
        }.to_json
    end
end