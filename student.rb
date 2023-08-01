require_relative 'person'

class Student < Person
  def initialize(id, classroom, age: nil, parent_permission: true, name: 'Unknown')
    super(id, age: age, parent_permission: parent_permission, name: name)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
