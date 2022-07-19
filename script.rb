student1 = Student.new('Joseph', 4, 44)
teacher1 = Teacher.new('Gilda', 'maths', 67)
person1 = Person.new('Ann', 17, parent_permission: false)
person = Person.new('maximilianus', 22)
person.correct_name
capitalizedPerson = CapitalizeDecorator.new(person)
capitalizedPerson.correct_name
capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
capitalizedTrimmedPerson.correct_name
