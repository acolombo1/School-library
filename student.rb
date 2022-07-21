class Student < Person
  def initialize(name, age = 'Unknown', parent_permission: true)
    super(name, age, parent_permission: parent_permission)
  end
  attr_reader :classroom

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
