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
    @classroom&.students&.delete(self)
    classroom&.students&.push(self)
  end
end
