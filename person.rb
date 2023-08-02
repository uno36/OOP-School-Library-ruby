require_relative 'nameable'
require_relative 'rental'

class Person
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(id, age: nil, parent_permission: true, name: 'Unknown')
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end
