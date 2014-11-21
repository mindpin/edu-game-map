module EduGameMap
  class MinicourseLearnedRecord
    include Mongoid::Document
    include Mongoid::Timestamps

    # 被工程引用后，调用这个方法从而关联工程中的 user 和 minicourse 模型
    def self.init!
      belongs_to :user
      belongs_to :minicourse # 关联 minicourse
    end
  end
end