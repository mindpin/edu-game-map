# EduGameMap

Progression map for online education services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'edu-game-map', github: 'mindpin/edu-game-map'
```

And then execute:

    $ bundle

## Usage

See `example` directory.

## api

在 rails 工程 config/initialize 目录中创建 rb 文件运行下面初始化代码
```ruby
EduGameMap.init!
```

```ruby
map = EduGameMap::Map.all.first
map.json_hash #=> json 数据的 hash 对象
map.nodes #=> EduGameMap::Node数组
map.begin_node #=> EduGameMap::Node数组


node.id
node.name
node.minicourse
node.map #=> node 所属的 map
node.jump_to_map #=> 此 node 可以跳转到的其他 map，不能是他所属的 map
node.parents #=> node 的所有父节点
node.children #=> node 的所有子节点
node.ancestors #=> node 的所有祖先节点（不包括它自己）
node.descendants #=> node 的所有子孙节点（不包括它自己）

node.is_begin_node? #=> node 是否起始节点（一个 map 一般只有一个起始节点。少数情况下有多个。没有父节点的节点就是起始节点）
node.is_learned_by?(user) #=> 指定用户是否学完了该节点
node.can_be_learn_by?(user) #=> 查询此节点是否可被指定用户学习
# 如果该节点是 node.is_begin_node? == true 则随时可学
# 如果该节点的 parents 均学完，则该节点可学


minicourse = EduGameMap::Minicourse.create(hash)

```