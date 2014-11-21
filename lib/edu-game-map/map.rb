module EduGameMap
  class Map
    include Mongoid::Document
    include Mongoid::Timestamps
    include EduGameMap::Map::JsonMethods
    scope :with_publised, ->{where(is_publised: true)}
    has_many :map_learned_records

    # json 内容
    field :json,        type: String
    # 和 json 内容中的 map 的 id 一致
    field :map_id,      type: String
    # 和 json 内容中的 map 的 name 一致
    field :map_name,    type: String
    # 是否发布
    field :is_publised, type: Boolean, default: false

    def publised!
      self.is_publised = true
      self.save
    end
  end
end