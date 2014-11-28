require "./lib/app"

def mkcourse(name)
  Course.find_or_create_by(:name => name)
end

def mklesson(course, name)
  lesson = Lesson.find_or_create_by(:name => name, :course_id => course.id)
  EduGameMap::Minicourse.find_or_create_by(:lesson_id => lesson.id)
end

course = mkcourse("Android开发")

sdklessons = [ 
  "准备Android SDK",
  "准备Java集成开发环境",
  "学习Java语言",
  "学习Android SDK基础 API"
]

ndklessons = [
  "准备Android NDK",
  "准备C/C++集成开发环境",
  "学习C/C++语言",
  "Android NDK 基础 API"
]

(%w{绪论} + sdklessons + ndklessons).each do |name|
  mklesson(course, name)
end

m1_json = File.read("./miscs/m1.json")
m1 = EduGameMap::Map.find_or_create_by(:map_name => "m1")
m1.json = m1_json
m1.save

m2_json = File.read("./miscs/m2.json")
m2 = EduGameMap::Map.find_or_create_by(:map_name => "m2")
m2.json = m2_json
m2.save

mzghhr_json = File.read("./miscs/mzghhr.json")
mzghhr = EduGameMap::Map.find_or_create_by(:map_name => "mzghhr")
mzghhr.json = mzghhr_json
mzghhr.save

puts "课程导入完成"
