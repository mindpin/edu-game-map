# 普通的标准渲染器，用来调试
class StandardRender
  constructor: (@map)->

  draw: ($paper)->
    @$paper = $paper

    @layout()

    for id, node of @map.nodes
      # console.log "id: #{id}, ", "x: #{node.depth}, ", "size: #{node.size}, ", "y: #{node.offset}"
      node.x = node.depth * 100 + 100
      node.y = node.offset * 100 + 100

      node.$el = jQuery '<div>'
        .addClass 'node'
        .html node.id
        .css
          'left': node.x
          'top': node.y
        .appendTo @$paper


    for id, node of @map.nodes
      for child in node.children
        @draw_canvas node, child

  draw_canvas: (node, child)->
    w = child.x + 30 - node.x
    h = child.y + 30 - node.y
    $canvas = jQuery '<canvas>'
      .attr 'width', w
      .attr 'height', h
      .css
        'left': node.x
        'top': node.y
      .appendTo @$paper

    ca = new CurveArrow $canvas[0]
    ca.draw 15, 15, w - 15, h - 15, '#999'

  layout: ->
    offset = 0
    for root in @map.roots
      root.size = @_r root, 0, offset
      offset = offset + root.size


  _r: (node, depth, offset)->
    node.depth = depth
    node.offset = offset
    _offset = 0
    for child in node.children
      child.size = @_r child, depth + 1, offset + _offset
      _offset = _offset + child.size

    return 1 if _offset is 0
    return _offset


jQuery ->
  url = 'data/sample.json'
  new GameMap.Map().load url, (map)->
    render = new StandardRender(map)
    render.draw jQuery('.paper')