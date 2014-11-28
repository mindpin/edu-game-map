module BSON
  class ObjectId   
    def to_json(*)
      to_s.to_json
    end
    def as_json(*)
      to_s.as_json
    end
  end
end

module EduGameMap
  class Minicourse
    belongs_to :lesson

    def as_json(options={})
      conf = {
        :except => [
          :_id, :lesson_id, :course_id
        ],

        :include => :lesson
      }

      super(options.merge(conf)).merge("id" => id.to_s)
    end
  end
end

class User
  include Mongoid::Document

  has_many :map_records, :class_name => "EduGameMap::MapLearnedRecord"

  field :name, :type => String
end

EduGameMap.init!

Mongoid.load!("./mongoid.yml")
