class Schema
    def self.build_schema
        schema = {
            "fieldType": [],
            "field": [],
            "copyField": [],
            "uniqueKey": "id",
            "name": "library_solr_config",
            "version": "1.6"
        }
        schema[:fieldType]
            .append(ISBNFieldType.new.to_json)
            .append(LCCNFieldType.new.to_json)
            .append(LCCNSortableFieldType.new.to_json)
        schema
    end
end