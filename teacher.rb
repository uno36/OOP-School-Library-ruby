require_relative 'person'

class Teacher < Person
  def initialize(id, specialization, age: nil, parent_permission: true, name: 'Unknown')
    super(id, age: age, parent_permission: parent_permission, name: name)
    @specialization = specialization
  end

  def can_use_services?
    true # Teachers can always use services
  end
end
