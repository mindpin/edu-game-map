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
      super(options.merge(:except => [:_id, :course_id])).merge("id" => id.to_s)
    end
  end
end

EduGameMap.init!

Mongoid.load!("./mongoid.yml")
