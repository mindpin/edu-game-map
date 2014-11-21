class Lesson
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  belongs_to :course

  has_one :minicourse, :class_name => EduGameMap::Minicourse.name

  def as_json(options={})
    super(options.merge(:except => [:_id, :course_id])).merge("id" => id.to_s)
  end
end

