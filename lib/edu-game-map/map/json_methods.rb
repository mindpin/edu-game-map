module EduGameMap
  class Map
    module JsonMethods
      extend ActiveSupport::Concern 

      included do
        before_validation :_set_map_id_and_name
      end

      def _set_map_id_and_name
        json_map_id   = json_hash["id"]
        json_map_name = json_hash["name"]

        self.map_id   = json_map_id   if json_map_id   != self.map_id
        self.map_name = json_map_name if json_map_name != self.map_name
      end

      def json_hash
        @json_hash ||= JSON.parse(self.json||"{}")
      end

      def nodes
        _parse_json_hash
        @nodes
      end

      def begin_nodes
        _parse_json_hash
        @begin_nodes
      end

      def _parse_json_hash
        @begin_nodes || begin
          id__node_hash = {}
          json_hash["nodes"].each do |node_hash|
            id__node_hash[node_hash["id"]] = EduGameMap::Node.new(self, node_hash)
          end
          json_hash["relations"].each do |relation|
            parent = id__node_hash[relation["parent"]]
            child = id__node_hash[relation["child"]]
            parent.send(:_add_child, child)
            child.send(:_add_parent, parent)
          end
          json_hash["jump"].each do |jump|
            node = id__node_hash[jump["node"]]
            map = EduGameMap::Map.where(:map_id => jump["map"]).first
            node.send(:_set_jump_to_map, map)
          end


          @nodes = id__node_hash.values
          @begin_nodes = @nodes.select do |node|
            node.parents.count == 0
          end
        end
      end
    end
  end
end