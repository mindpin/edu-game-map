require "./lib/app"

def mkcourse(x)
  Course.find_or_create_by(:name => "课程#{x}")
end

def mklesson(course, x)
  Lesson.find_or_create_by(:name => "#{course.name} - 第#{x}节", :course_id => course.id)
end

#
# course1和course2 分别对应
# https://github.com/mindpin/edu-game-map/issues/2#issuecomment-63586844
# 中两张图里的 m1, m2
#
puts "======== 开始生成数据"
1.upto(2).each do |x|
  course = mkcourse(x)

  count = case x
          when 1 then 11
          when 2 then 4
          end

  1.upto(count).each do |y|
    mklesson(course, y)

    nr = y == count ? "\n" : "\r"
    print "-- 课程(#{x}/2) - 课节(#{y}/#{count})#{nr}"
  end
end
puts "======== 结束生成数据"
