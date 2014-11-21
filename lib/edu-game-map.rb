require File.expand_path("../edu-game-map/version", __FILE__)
require File.expand_path("../edu-game-map/map/json_methods", __FILE__)
require File.expand_path("../edu-game-map/map_learned_record/json_methods", __FILE__)
require File.expand_path("../edu-game-map/map", __FILE__)
require File.expand_path("../edu-game-map/node", __FILE__)
require File.expand_path("../edu-game-map/minicourse", __FILE__)
require File.expand_path("../edu-game-map/map_learned_record", __FILE__)
require File.expand_path("../edu-game-map/minicourse_learned_record", __FILE__)

module EduGameMap
  def self.init!
    # 使用该 gem 时，在 initialize 中调用该方法
    EduGameMap::MapLearnedRecord.init!
    EduGameMap::MinicourseLearnedRecord.init!
  end
end

