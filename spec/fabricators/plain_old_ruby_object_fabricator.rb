Fabricator(:parent_ruby_object) do
  transient :placeholder, :transient_with_default => 'my custom value'
  dynamic_field { |attrs| attrs[:placeholder] }
  nil_field nil
  number_field 5
  string_field 'content'
  false_field false
  extra_fields { Hash.new }
  other_child
  before_validation do |object, transients|
    object.extra_fields[:transient_value] = transients[:placeholder]
  end
end

Fabricator(:parent_ruby_object_with_children, from: :parent_ruby_object) do
  child_ruby_objects(:count => 2)
end

Fabricator(:child_ruby_object) do
  number_field 10
end

Fabricator(:other_child, from: :child_ruby_object) do
  number_field 10
end

Fabricator(:child_ruby_object_with_parent, from: :child_ruby_object) do
  parent_ruby_object
end

Fabricator(:child_ruby_object_with_forced_parent, from: :child_ruby_object) do
  parent_ruby_object { Fabricate.create!(:parent_ruby_object) }
end

Fabricator('namespaced_classes/ruby_object')

Fabricator(:predefined_namespaced_class, from: 'namespaced_classes/ruby_object') do
  name 'aaa'
end

Fabricator(:troublemaker)
