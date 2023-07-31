class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(id, age: nil, parent_permission: true, name: 'Unknown')
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age && @age >= 18
  end
end
