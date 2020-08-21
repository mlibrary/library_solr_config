class FieldType
    def self.get_type(name)
        case name
        when "binary"
            BinaryType.new
        when "boolean"
            BooleanType.new
        when "date"
            DateType.new
        when "double"
            DoubleType.new
        when "float"
            FloatType.new
        when "int"
            IntType.new
        when "long"
            LongType.new
        when 'string'
            StringType.new
        when 'facet'
            FacetType.new
        when 'single_date_stored'
            SingleDateStoredType.new
        when 'ignored'
            IgnoredType.new
        when 'location_rpt'
            LocationRptType.new
        when 'point'
            PointType.new
        end
    end
end

class BinaryType
    def solr_class
        "solr.BinaryField"
    end

    def name
        "binary"
    end

    def to_json
        {
            "class" => solr_class,
            "name" => name
        }.to_json
    end
end

class BooleanType
    def solr_class
        "solr.BoolField"
    end

    def name
        "boolean"
    end

    def sort_missing_last
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "sortMissingLast": sort_missing_last
        }.to_json
    end
end

class SolrTrieField
    def precision_step
        0
    end

    def position_increment_gap
        0
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "precisionStep": precision_step,
            "positionIncrementGap": position_increment_gap
        }.to_json
    end
end

class DateType < SolrTrieField
    def solr_class
        "solr.TrieDateField"
    end

    def name
        "date"
    end

    def precision_step
        0
    end

    def position_increment_gap
        0
    end
end

class DoubleType < SolrTrieField
    def name
        "double"
    end

    def solr_class
        "solr.TrieDoubleField"
    end
end

class FloatType < SolrTrieField
    def name
        "float"
    end

    def solr_class
        "solr.TrieFloatField"
    end
end

class IntType < SolrTrieField
    def name
        "int"
    end

    def solr_class
        "solr.TrieIntField"
    end

    def doc_values
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "precisionStep": precision_step,
            "positionIncrementGap": position_increment_gap,
            "docValues": doc_values
        }.to_json
    end
end

class LongType < SolrTrieField
    def name
        "long"
    end

    def solr_class
        "solr.TrieLongField"
    end

    def doc_values
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "precisionStep": precision_step,
            "positionIncrementGap": position_increment_gap,
            "docValues": doc_values
        }.to_json
    end
end

class StringType
    def name
        "string"
    end

    def solr_class
        "solr.StrField"
    end

    def stored
        false
    end

    def indexed
        false
    end

    def multi_valued
        false
    end

    def doc_values
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "stored": stored,
            "indexed": indexed,
            "multiValued": multi_valued,
            "docValues": doc_values
        }.to_json
    end
end

class FacetType
    def name
        "facet"
    end

    def solr_class
        "solr.StrField"
    end

    def stored
        false
    end

    def indexed
        true
    end

    def multi_valued
        true
    end

    def doc_values
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "stored": stored,
            "indexed": indexed,
            "multiValued": multi_valued,
            "docValues": doc_values
        }.to_json
    end
end

class SingleDateStoredType
    def name
        "single_date_stored"
    end

    def solr_class
        "solr.TrieDateField"
    end

    def stored
        false
    end

    def indexed
        false
    end

    def multi_valued
        false
    end

    def doc_values
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "stored": stored,
            "indexed": indexed,
            "multiValued": multi_valued,
            "docValues": true
        }.to_json
    end
end

class IgnoredType
    def solr_class
        "solr.StrField"
    end

    def name
        "ignored"
    end

    def stored
        false
    end

    def indexed
        false
    end

    def multi_valued
        true
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "stored": stored,
            "indexed": indexed,
            "multiValued": multi_valued
        }.to_json
    end
end

class LocationRptType
    def name
        "location_rpt"
    end

    def solr_class
        "solr.SpatialRecursivePrefixTreeFieldType"
    end

    def geo
        true
    end

    def dist_err_pct
        0.025
    end

    def max_dist_err
        0.000009
    end

    def distance_units
        "degrees"
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "geo": geo,
            "distErrPct": dist_err_pct,
            "maxDistErr": max_dist_err,
            "distanceUnits": distance_units
        }.to_json
    end
end

class PointType
    def solr_class
        "solr.PointType"
    end

    def name
        "point"
    end

    def dimension
        2
    end

    def sub_field_suffix
        "d"
    end

    def to_json
        {
            "class": solr_class,
            "name": name,
            "dimension": dimension,
            "subFieldSuffix": sub_field_suffix
        }.to_json
    end
end