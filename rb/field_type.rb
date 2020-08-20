class FieldType
    def self.get_type(name)
        BinaryType.new
    end
end

class BinaryType
    def solr_class
        "solr.BinaryField"
    end
end