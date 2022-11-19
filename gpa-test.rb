class Calculator
  attr_reader :name, :grades

  def initialize(name, grades)
    @name = name
    @grades = grades
  end

  def gpa
    if grades_check
      grades_array = collect_converted_grades
      average_grade = average_the_array(grades_array)
      average_grade.round(1)
    else
      false
    end
  end

  def announcement
    if gpa
      "#{@name} scored an average of #{gpa.to_f}"
    else
      "Something went wrong with #{@name} Grades, please check if you typed the grades Correctly"
    end
  end

  private

  # I`ve decided to make these new methods, because they can be reused in the future.
  # At the moment the methods can stay as private as they are only called inside the class Calculator

  # Methodo to check if the grades are valid
  def grades_check
    return unless @grades.instance_of?(Array)

    grades_array = collect_converted_grades
    grades_array.size.positive? && grades_array.none?(nil)
  end

  # For grades_conversion I thought about 3 different options here, if statements, case when statements and a hash with key and values
  # I've opted for Hash because It can work as a Database.
  # grades_conversion also can be re in the future if you need to convert a grade for any other reason.
  def grades_conversion(grade)
    grades_hash = {
      'A' => 4, 'A-' => 3.7,
      'B+' => 3.3, 'B' => 3, 'B-' => 2.7,
      'C+' => 2.3, 'C' => 2, 'C-' => 1.7,
      'D+' => 1.3, 'D' => 1, 'D-' => 0.7,
      'E+' => 0.5, 'E' => 0.2, 'E-' => 0.1,
      'F' => 0,
      'U' => -1
    }
    grades_hash[grade]
  end

  # I used collect to get an array of converted grades. Again it is reausable
  def collect_converted_grades
    @grades.collect { |grade| grades_conversion(grade) }
  end

  # Ruby doesn`t have a method to average and array of integers so we had to create our won
  # I used collect to get an array of converted grades. Again it is reausable
  def average_the_array(grades_array)
    grades_array.sum(0.0) / grades_array.size
  end
end

# I have added my tests for how_might_you_do_these, I`ve done a general Error handling,
# But we can deal with each individual possible erro giving a better Feedback to the User, that would require a bit more time to develop.

how_might_you_do_these = [
  { in: { name: 'Non-grades', grades: ["N"]}, out: { gpa: false, announcement: "Something went wrong with Non-grades Grades, please check if you typed the grades Correctly"  } },
  { in: { name: 'Non-strings', grades: ["A", :B] },  out: { gpa: false, announcement: "Something went wrong with Non-strings Grades, please check if you typed the grades Correctly"  } },
  { in: { name: 'Empty', grades: [] }, out: { gpa: false, announcement: "Something went wrong with Empty Grades, please check if you typed the grades Correctly"  } },
  { in: { name: 'Numbers', grades: [1, 2] }, out: { gpa: false, announcement: "Something went wrong with Numbers Grades, please check if you typed the grades Correctly"  } },
  { in: { name: 'Passed a string', grades: "A A-" }, out: { gpa: false, announcement: "Something went wrong with Passed a string Grades, please check if you typed the grades Correctly"  } },
]

how_might_you_do_these.each do |test|
  user = Calculator.new(test[:in][:name], test[:in][:grades])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:gpa, :announcement].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected '#{expected}' but got '#{result}'"
    end
  end

  puts
end

# For CoverageBook's tests I had to change the names of Emma, Frida and Gary on the announcement because they had Beryl instead,

## Do not edit below here ##################################################

tests = [
  { in: { name: 'Andy',  grades: ["A"] }, out: { gpa: 4, announcement: "Andy scored an average of 4.0"  } },
  { in: { name: 'Beryl',  grades: ["A", "B", "C"] }, out: { gpa: 3, announcement: "Beryl scored an average of 3.0"  } },
  { in: { name: 'Chris',  grades: ["B-", "C+"] }, out: { gpa: 2.5, announcement: "Chris scored an average of 2.5"  } },
  { in: { name: 'Dan',  grades: ["A", "A-", "B-"] }, out: { gpa: 3.5, announcement: "Dan scored an average of 3.5"  } },
  { in: { name: 'Emma',  grades: ["A", "B+", "F"] }, out: { gpa: 2.4, announcement: "Emma scored an average of 2.4"  } },
  { in: { name: 'Frida',  grades: ["E", "E-"] }, out: { gpa: 0.2, announcement: "Frida scored an average of 0.2"  } },
  { in: { name: 'Gary',  grades: ["U", "U", "B+"] }, out: { gpa: 0.4, announcement: "Gary scored an average of 0.4"  } },
]

# how_might_you_do_these = [
#   { in: { name: 'Non-grades',  grades: ["N"] } },
#   { in: { name: 'Non-strings',  grades: ["A", :B] } },
#   { in: { name: 'Empty',  grades: [] } },
#   { in: { name: 'Numbers',  grades: [1, 2] } },
#   { in: { name: 'Passed a string',  grades: "A A-" } },
# ]

tests.each do |test|
  user = Calculator.new(test[:in][:name], test[:in][:grades])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:gpa, :announcement].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected '#{expected}' but got '#{result}'"
    end
  end

  puts
end
