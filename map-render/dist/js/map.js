(function() {
  var Map, Node, Relation;

  Node = (function() {
    function Node(map, data) {
      this.map = map;
      this.id = data.id;
      this.name = data.name;
      this.children = [];
      this.parents = [];
    }

    return Node;

  })();

  Relation = (function() {
    function Relation(map, data) {
      this.map = map;
      this.parent_id = data.parent;
      this.child_id = data.child;
      this.parent = this.map.get_node(this.parent_id);
      this.child = this.map.get_node(this.child_id);
      this.parent.children.push(this.child);
      this.child.parents.push(this.parent);
    }

    return Relation;

  })();

  Map = (function() {
    function Map() {
      this.id = null;
      this.name = null;
      this.nodes = {};
      this.relations = [];
      this.roots = [];
    }

    Map.prototype.load = function(url, func) {
      return jQuery.getJSON(url, (function(_this) {
        return function(data) {
          var id, node, node_data, relation_data, _i, _j, _len, _len1, _ref, _ref1, _ref2;
          _this.id = data.id;
          _this.name = data.name;
          _ref = data.nodes;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            node_data = _ref[_i];
            node = new Node(_this, node_data);
            _this.nodes[node.id] = node;
          }
          _ref1 = data.relations;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            relation_data = _ref1[_j];
            _this.relations.push(new Relation(_this, relation_data));
          }
          _ref2 = _this.nodes;
          for (id in _ref2) {
            node = _ref2[id];
            if (node.parents.length === 0) {
              _this.roots.push(node);
            }
          }
          return func(_this);
        };
      })(this));
    };

    Map.prototype.get_node = function(node_id) {
      return this.nodes[node_id];
    };

    return Map;

  })();

  window.GameMap = {
    Node: Node,
    Relation: Relation,
    Map: Map
  };

}).call(this);

//# sourceMappingURL=../maps/map.js.map