module EduGameMap
  class MapLearnedRecord
    include Mongoid::Document
    include Mongoid::Timestamps
    include EduGameMap::MapLearnedRecord::JsonMethods

    belongs_to :map

    # json 内容
    field :json,  type: String

    # 被工程引用后，调用这个方法从而关联工程中的 user 模型
    def self.init!
      belongs_to :user
    end
  end
end