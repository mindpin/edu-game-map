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
      end.uniq
    end

    def descendants
      @descendants || begin
        descendants = []
        _get_children(self, descendants)
        descendants
      end.uniq
    end


    def is_begin_node?
      @parents.count == 0
    end

    def is_learned_by?(user)
      mlr = EduGameMap::MapLearnedRecord.where(:map_id => self.map.id.to_s, :user_id => user.id.to_s).first
      return false if mlr.blank?
      mlr.learned_node_ids.include?(self.id)
    end

    def can_be_learn_by?(user)
      mlr = EduGameMap::MapLearnedRecord.where(:map_id => self.map.id.to_s, :user_id => user.id.to_s).first
      return false if mlr.blank? && self.parents.count != 0

      self.parents.select do |parent|
        !mlr.learned_node_ids.include?(parent.id)
      end.count == 0
    end

    def do_learn_by(user)
      return if !can_be_learn_by?(user)
      mlr = map.map_learned_records.where(:user_id => user.id.to_s).first
      if mlr.blank?
        mlr = map.map_learned_records.create(:user => user)
      end
      if !mlr.learned_node_ids.include?(self.id)
        mlr.add_learned_node_id!(self.id)
      end

      if !self.minicourse.blank?
        node.minicourse.do_learn_by(user)
      end
    end

    def set_minicourse!(minicourse)
      nodes_hash = @map.json_hash["nodes"]
      node_ids = nodes_hash.map{|node_hash|node_hash["id"]}
      index = node_ids.index(self.id)
      nodes_hash[index]["minicourse"] = minicourse.id.to_s
      @map.json = @map.json_hash.to_json
      @map.save!
      @minicourse = minicourse
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