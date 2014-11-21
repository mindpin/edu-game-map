module EduGameMap
  class Node
    attr_reader :id, :name, :minicourse, :children, :parents, :jump_to_map, :map
    def initialize(map, hash)
      @map  = map
      @id   = hash["id"]
      @name = hash["name"]
      @parents  = []
      @children = []
      if !hash["minicourse"].blank?
        @minicourse = EduGameMap::Minicourse.where(:id => hash["minicourse"]).first
      end
    end

    def ancestors
      @ancestors || begin
        ancestors = []
        _get_parents(self, ancestors)
        ancestors
      end
    end

    def descendants
      @descendants || begin
        descendants = []
        _get_children(self, descendants)
        descendants
      end
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

    private
      def _get_children(node, descendants)
        node.children.each do |child|
          descendants << child
          _get_children(child, descendants)
        end
      end

      def _get_parents(node, ancestors)
        node.parents.each do |parent|
          ancestors << parent
          _get_parents(parent, ancestors)
        end
      end

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

  end
end