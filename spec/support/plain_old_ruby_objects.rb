require 'ostruct'

class Persistable
  def persisted?
    @persisted
  end
  def save!
    @persisted = true
  end
end

class ParentRubyObject < Persistable
  attr_accessor \
    :before_save_value,
    :dynamic_field,
    :nil_field,
    :number_field,
    :string_field,
    :false_field,
    :id,
    :extra_fields,
    :other_child
  attr_writer :child_ruby_objects

  def initialize
    self.id = 23
    self.before_save_value = 11
  end

  def save!
    super
    other_child.save! if other_child
    child_ruby_objects.each(&:save!)
  end

  def child_ruby_objects
    @child_ruby_objects ||= []
  end
end

class ChildRubyObject < Persistable
  attr_accessor \
    :parent_ruby_object,
    :parent_ruby_object_id,
    :number_field

  def parent_ruby_object=(parent_ruby_object)
    @parent_ruby_object = parent_ruby_object
    @parent_ruby_object_id = parent_ruby_object.id
  end
end

module NamespacedClasses
  class RubyObject < OpenStruct
    attr_accessor :display
  end
end

class Troublemaker
  def raise_exception=(value)
    raise "Troublemaker exception" if value
  end
end

class Sequencer
  attr_accessor :simple_iterator, :param_iterator, :block_iterator

  class Namespaced
    attr_accessor :iterator
  end
end
