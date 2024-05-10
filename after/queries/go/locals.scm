; extends

(var_spec) @scope

(field_declaration
  name: (field_identifier) @definition.field)

(type_declaration
  (type_spec
    name: (type_identifier) @name
    type: [(struct_type) (interface_type)] @type)) @start
