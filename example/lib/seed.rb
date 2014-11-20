require "./lib/app"

def mkcourse(x)
  Course.find_or_create_by(:name => "课程#{x}")
end

def mklesson(course, x)
  Lesson.find_or_create_by(:name => "#{course.name} - 第#{x}节", :course_id => course.id)
end

puts "======== 开始生成数据"
1.upto(8).each do |x|
  course = mkcourse(x)

  count = rand 6..23

  1.upto(6 + (7..count).size).each do |y|
    mklesson(course, y)

    nr = y == count ? "\n" : "\r"
    print "-- 课程(#{x}/8) - 课节(#{y}/#{count})#{nr}"
  end
end
puts "======== 结束生成数据"
