(function() {
  var StandardRender;

  StandardRender = (function() {
    function StandardRender(map) {
      this.map = map;
    }

    StandardRender.prototype.draw = function($paper) {
      var child, id, node, _ref, _ref1, _results;
      this.$paper = $paper;
      this.layout();
      _ref = this.map.nodes;
      for (id in _ref) {
        node = _ref[id];
        node.x = node.depth * 100 + 100;
        node.y = node.offset * 100 + 100;
        node.$el = jQuery('<div>').addClass('node').html(node.id).css({
          'left': node.x,
          'top': node.y
        }).appendTo(this.$paper);
      }
      _ref1 = this.map.nodes;
      _results = [];
      for (id in _ref1) {
        node = _ref1[id];
        _results.push((function() {
          var _i, _len, _ref2, _results1;
          _ref2 = node.children;
          _results1 = [];
          for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
            child = _ref2[_i];
            _results1.push(this.draw_canvas(node, child));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    StandardRender.prototype.draw_canvas = function(node, child) {
      var $canvas, ca, h, w;
      w = child.x + 30 - node.x;
      h = child.y + 30 - node.y;
      $canvas = jQuery('<canvas>').attr('width', w).attr('height', h).css({
        'left': node.x,
        'top': node.y
      }).appendTo(this.$paper);
      ca = new CurveArrow($canvas[0]);
      return ca.draw(15, 15, w - 15, h - 15, '#999');
    };

    StandardRender.prototype.layout = function() {
      var offset, root, _i, _len, _ref, _results;
      offset = 0;
      _ref = this.map.roots;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        root = _ref[_i];
        root.size = this._r(root, 0, offset);
        _results.push(offset = offset + root.size);
      }
      return _results;
    };

    StandardRender.prototype._r = function(node, depth, offset) {
      var child, _i, _len, _offset, _ref;
      node.depth = depth;
      node.offset = offset;
      _offset = 0;
      _ref = node.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        child.size = this._r(child, depth + 1, offset + _offset);
        _offset = _offset + child.size;
      }
      if (_offset === 0) {
        return 1;
      }
      return _offset;
    };

    return StandardRender;

  })();

  jQuery(function() {
    var url;
    url = 'data/sample.json';
    return new GameMap.Map().load(url, function(map) {
      var render;
      render = new StandardRender(map);
      return render.draw(jQuery('.paper'));
    });
  });

}).call(this);

//# sourceMappingURL=../maps/ui.js.map