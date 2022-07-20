class Classroom
  def initialize(label)
    @label = label
    @students = []
  end
  attr_accessor :label

  def add_student(student)
    student.classroom = self
    students.push(student) unless students.include?(student)
  end
end
