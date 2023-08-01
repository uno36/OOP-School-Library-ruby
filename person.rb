class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(_id, age: nil, parent_permission: true, name: 'Unknown')
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
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

# Step 1: Create the Nameable class
class Nameable
  def correct_name
    raise NotImplementedError, 'You must implement the correct_name method.'
  end
end

# Step 2: Create the Decorator base class
class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

# Step 3: Create the CapitalizeDecorator class
class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end

# Step 4: Create the TrimmerDecorator class
class TrimmerDecorator < Decorator
  def correct_name
    super[0..9]
  end
end
