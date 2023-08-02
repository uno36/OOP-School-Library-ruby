require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, age: nil, parent_permission: true, name: 'Unknown')
    super(id, age: age, parent_permission: parent_permission, name: name)
    @classroom = nil
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom&.students&.delete(self)
    @classroom = classroom
    classroom&.students&.push(self)
  end
end
