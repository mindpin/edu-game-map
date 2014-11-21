module EduGameMap
  class Node
    attr_reader :id, :name, :children, :parents, :jump_to_map, :map
    def initialize(map, hash)
      @map  = map
      @id   = hash["id"]
      @name = hash["name"]
      @parents  = []
      @children = []
    end

    private
    def _add_child(child)
      return if @children.include?(child)
      @children << child
    end

    def _add_parent(parent)
      return if @parents.include?(parent)
      @parents << parent
    end

    def _set_jump_to_map(map)
      @jump_to_map = map
    end

    def is_begin_node?
      @parents.count == 0
    end

    def is_learned_by?(user)
      mlr = EduGameMap::MapLearnedRecord.where(:map_id => self.map.map_id, :user_id => user.id).first
      mlr.learned_node_ids.include?(self.id)
    end

    def can_be_learn_by?(user)
      mlr = EduGameMap::MapLearnedRecord.where(:map_id => self.map.map_id, :user_id => user.id).first
      self.parents.select do |parent|
        !mlr.learned_node_ids.include?(parent.id)
      end.count == 0
    end
  end
end