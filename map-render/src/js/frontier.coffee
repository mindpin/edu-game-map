class ClassToggler
  constructor: (@klasses...)->
    # ..

  toggle: (klass, $elm)->
    return if not (klass in @klasses)
    for k in @klasses
      $elm.removeClass k
    $elm.addClass klass

class MapBinder
  constructor: (@$el, @node_klass, @line_klass)->
    @klass_toggler = new ClassToggler 'hide', 'ready', 'done'
    @klass_toggler.toggle 'hide', @$el.find(@node_klass)

    @line_toggler = new ClassToggler 'hide', 'show'

    @bind_events()

  # 将 map 数据应用于当前地图
  render: (map)->
    @map = map

    # 将所有节点和 dom 建立关联
    for id, node of map.nodes
      node._elm = @$el.find("#{@node_klass}[data-node=#{id}]")

    for root in map.roots
      @klass_toggler.toggle 'ready', root._elm

  bind_events: ->
    that = this

    @$el.delegate "#{@node_klass}.ready", 'click', ->
      node_id = jQuery(this).data('node')
      node = that.map.get_node node_id
      that.toggle_to_done node

    @$el.delegate "#{@node_klass}.done", 'click', ->
      node_id = jQuery(this).data('node')
      node = that.map.get_node node_id
      for child in node.children
        return if child._elm_state is 'done'
      that.toggle_to_ready node

  toggle_to_done: (node)->
    @klass_toggler.toggle 'done', node._elm
    node._elm_state = 'done'
    for child in node.children
      @toggle_to_ready child
      $line = @$el.find("#{@line_klass}[data-from=#{node.id}][data-to=#{child.id}]")
      @line_toggler.toggle 'show', $line

  toggle_to_ready: (node)->
    @klass_toggler.toggle 'ready', node._elm
    node._elm_state = 'ready'
    for child in node.children
      @toggle_to_hide child
      $line = @$el.find("#{@line_klass}[data-from=#{node.id}][data-to=#{child.id}]")
      @line_toggler.toggle 'hide', $line

  toggle_to_hide: (node)->
    @klass_toggler.toggle 'hide', node._elm
    node._elm_state = 'hide'
    for child in node.children
      @toggle_to_hide child


jQuery ->
  mb = new MapBinder jQuery('.frontier-map'), '.flag', '.line'

  url = 'data/m1.json'
  new GameMap.Map().load url, (map)->
    mb.render map