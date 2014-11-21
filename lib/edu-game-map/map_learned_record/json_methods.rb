module EduGameMap
  class MapLearnedRecord
    module JsonMethods
      extend ActiveSupport::Concern 

      included do
        before_validation :_set_map_id
      end

      def _set_map_id
        json_map_id  = _json_hash["map"]
        json_user_id = _json_hash["user"]
        self.map_id  = json_map_id  if json_map_id  != self.map_id
        self.user_id = json_user_id if json_user_id != self.user_id
      end

      def _json_hash
        @json_hash ||= JSON.parse(self.json)
      end

      def learned_node_ids
        _json_hash["learned_nodes"]
      end

    end
  end
end