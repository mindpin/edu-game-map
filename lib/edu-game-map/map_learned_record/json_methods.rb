module EduGameMap
  class MapLearnedRecord
    module JsonMethods
      extend ActiveSupport::Concern 

      included do
        before_validation :_set_map_id
      end

      def _set_map_id
        json_map_id  = json_hash["map"]
        json_user_id = json_hash["user"]

        if json_map_id  != self.map_id
          json_hash["map"] = self.map_id.to_s
        end
        if json_user_id != self.user_id
          json_hash["user"] = self.user_id.to_s
        end

        self.json = json_hash.to_json
      end

      def json_hash
        @json_hash ||= JSON.parse(self.json||"{}")
      end

      def learned_node_ids
        json_hash["learned_nodes"] ||= []
      end

      def add_learned_node_id!(node_id)
        learned_node_ids << node_id
        self.json = json_hash.to_json
        self.save
      end
    end
  end
end