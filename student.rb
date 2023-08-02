require_relative 'person'

class Student < Person
  def initialize(id, age: nil, parent_permission: true, name: 'Unknown')
    super(id, age: age, parent_permission: parent_permission, name: name)
    @classroom = nil
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
