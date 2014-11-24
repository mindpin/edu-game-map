module EduGameMap
  class Minicourse
    include Mongoid::Document
    include Mongoid::Timestamps
    has_many :minicourse_learned_records
    # 其他逻辑(暂时想不到)

    def is_learned_by?(user)
      minicourse_learned_records.where(:user_id => user.id.to_s).count != 0
    end

    def do_learn_by(user)
      return if minicourse_learned_records.where(:user_id => user.id.to_s).count != 0

      minicourse_learned_records.create(:user => user)
    end
  end
end