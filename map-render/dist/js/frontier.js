(function() {
  var ClassToggler, MapBinder,
    __slice = [].slice,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ClassToggler = (function() {
    function ClassToggler() {
      var klasses;
      klasses = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.klasses = klasses;
    }

    ClassToggler.prototype.toggle = function(klass, $elm) {
      var k, _i, _len, _ref;
      if (!(__indexOf.call(this.klasses, klass) >= 0)) {
        return;
      }
      _ref = this.klasses;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        k = _ref[_i];
        $elm.removeClass(k);
      }
      return $elm.addClass(klass);
    };

    return ClassToggler;

  })();

  MapBinder = (function() {
    function MapBinder($el, node_klass, line_klass) {
      this.$el = $el;
      this.node_klass = node_klass;
      this.line_klass = line_klass;
      this.klass_toggler = new ClassToggler('hide', 'ready', 'done');
      this.klass_toggler.toggle('hide', this.$el.find(this.node_klass));
      this.line_toggler = new ClassToggler('hide', 'show');
      this.bind_events();
    }

    MapBinder.prototype.render = function(map) {
      var id, node, root, _i, _len, _ref, _ref1, _results;
      this.map = map;
      _ref = map.nodes;
      for (id in _ref) {
        node = _ref[id];
        node._elm = this.$el.find("" + this.node_klass + "[data-node=" + id + "]");
      }
      _ref1 = map.roots;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        root = _ref1[_i];
        _results.push(this.klass_toggler.toggle('ready', root._elm));
      }
      return _results;
    };

    MapBinder.prototype.bind_events = function() {
      var that;
      that = this;
      this.$el.delegate("" + this.node_klass + ".ready", 'click', function() {
        var node, node_id;
        node_id = jQuery(this).data('node');
        node = that.map.get_node(node_id);
        return that.toggle_to_done(node);
      });
      return this.$el.delegate("" + this.node_klass + ".done", 'click', function() {
        var child, node, node_id, _i, _len, _ref;
        node_id = jQuery(this).data('node');
        node = that.map.get_node(node_id);
        _ref = node.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          if (child._elm_state === 'done') {
            return;
          }
        }
        return that.toggle_to_ready(node);
      });
    };

    MapBinder.prototype.toggle_to_done = function(node) {
      var $line, child, _i, _len, _ref, _results;
      this.klass_toggler.toggle('done', node._elm);
      node._elm_state = 'done';
      _ref = node.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        this.toggle_to_ready(child);
        $line = this.$el.find("" + this.line_klass + "[data-from=" + node.id + "][data-to=" + child.id + "]");
        _results.push(this.line_toggler.toggle('show', $line));
      }
      return _results;
    };

    MapBinder.prototype.toggle_to_ready = function(node) {
      var $line, child, _i, _len, _ref, _results;
      this.klass_toggler.toggle('ready', node._elm);
      node._elm_state = 'ready';
      _ref = node.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        this.toggle_to_hide(child);
        $line = this.$el.find("" + this.line_klass + "[data-from=" + node.id + "][data-to=" + child.id + "]");
        _results.push(this.line_toggler.toggle('hide', $line));
      }
      return _results;
    };

    MapBinder.prototype.toggle_to_hide = function(node) {
      var child, _i, _len, _ref, _results;
      this.klass_toggler.toggle('hide', node._elm);
      node._elm_state = 'hide';
      _ref = node.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(this.toggle_to_hide(child));
      }
      return _results;
    };

    return MapBinder;

  })();

  jQuery(function() {
    var mb, url;
    mb = new MapBinder(jQuery('.frontier-map'), '.flag', '.line');
    url = 'data/m1.json';
    return new GameMap.Map().load(url, function(map) {
      return mb.render(map);
    });
  });

}).call(this);

//# sourceMappingURL=../maps/frontier.js.map