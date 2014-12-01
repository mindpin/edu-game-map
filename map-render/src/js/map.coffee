class Node
  constructor: (@map, data)->
    @id = data.id
    @name = data.name

    @children = []
    @parents = []


class Relation
  constructor: (@map, data)->
    @parent_id = data.parent
    @child_id = data.child

    @parent = @map.get_node @parent_id
    @child = @map.get_node @child_id

    @parent.children.push @child
    @child.parents.push @parent


class Map
  constructor: ->
    @id = null
    @name = null
    @nodes = {}
    @relations = []
    @roots = []

  load: (url, func)->
    jQuery.getJSON url, (data)=>
      @id = data.id
      @name = data.name
      
      for node_data in data.nodes
        node = new Node(@, node_data)
        @nodes[node.id] = node

      for relation_data in data.relations
        @relations.push new Relation(@, relation_data)

      for id, node of @nodes
        @roots.push node if node.parents.length is 0

      # console.log @nodes, @relations

      func(@)

  get_node: (node_id)->
    @nodes[node_id]


window.GameMap = {
  Node : Node
  Relation : Relation
  Map : Map
}