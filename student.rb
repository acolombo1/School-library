class Student < Person
  def initialize(name, classroom, age = 'Unknown', parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students.push(self)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
