require_relative 'person'

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
    @nameable.correct_name.capitalize
  end
end

# Step 4: Create the TrimmerDecorator class
class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name[0..9]
  end
end
