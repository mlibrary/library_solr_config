class FieldType
    def self.registry
        @registry ||= []
    end

    def self.register(candidate)
        registry.prepend(candidate)
    end

    def self.get_type(name)
        registry.find {|candidate| candidate.handles?(name) }.new
    end
end

class BinaryType
    FieldType.register(self)

    def self.handles?(name)
        name == "binary"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "boolean"
    end

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

class DateType
    FieldType.register(self)

    def self.handles?(name)
        name == "date"
    end

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

    def to_json
        {
            "class": solr_class,
            "name": name,
            "precisionStep": precision_step,
            "positionIncrementGap": position_increment_gap
        }.to_json
    end
end

class DoubleType
    FieldType.register(self)

    def self.handles?(name)
        name == "double"
    end

    def name
        "double"
    end

    def solr_class
        "solr.TrieDoubleField"
    end

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

class FloatType
    FieldType.register(self)

    def self.handles?(name)
        name == "float"
    end

    def name
        "float"
    end

    def solr_class
        "solr.TrieFloatField"
    end

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

class IntType
    FieldType.register(self)

    def self.handles?(name)
        name == "int"
    end

    def name
        "int"
    end

    def solr_class
        "solr.TrieIntField"
    end

    def doc_values
        true
    end

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
            "positionIncrementGap": position_increment_gap,
            "docValues": doc_values
        }.to_json
    end
end

class LongType
    FieldType.register(self)

    def self.handles?(name)
        name == "long"
    end

    def name
        "long"
    end

    def solr_class
        "solr.TrieLongField"
    end

    def precision_step
        0
    end

    def position_increment_gap
        0
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
    FieldType.register(self)

    def self.handles?(name)
        name == "string"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "facet"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "single_date_stored"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "ignored"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "location_rpt"
    end

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
    FieldType.register(self)

    def self.handles?(name)
        name == "point"
    end

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