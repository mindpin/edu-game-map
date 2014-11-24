RSpec.describe EduGameMap::Map do
  it "parse map" do
    map = EduGameMap::Map.create
    expect(map.json).to eq(nil)
    m1_json = IO.read(File.expand_path("../data/m1.json", __FILE__))
    map.json = m1_json
    map.save!
    expect(map.nodes.count).to eq(11)
    expect(map.begin_nodes.count).to eq(1)

    fnode = map.begin_nodes.first
    expect(fnode.id).to eq("1")
    expect(fnode.name).to eq("n1name")
    expect(fnode.map.map_name).to eq("m1name")
    expect(fnode.jump_to_map).to eq(nil)
    expect(fnode.parents).to eq([])
    expect(fnode.children.map{|n|n.name}).to eq(["n2name", "n3name", "n5name"])
    expect(fnode.ancestors.map{|n|n.name}).to eq([])
    expect(fnode.descendants.map{|n|n.name}).to eq(["n2name", "n4name", "n8name", "n5name", "n3name", "n6name", "n9name", "n10name", "n11name", "n7name"])
    expect(fnode.is_begin_node?).to eq(true)


    node9 = map.nodes[8]
    expect(node9.parents.map{|n|n.name}).to eq(["n6name", "n7name"])
    expect(node9.children.map{|n|n.name}).to eq(["n10name", "n11name"])
    expect(node9.ancestors.map{|n|n.name}).to eq(["n6name", "n3name", "n1name", "n7name"])
    expect(node9.descendants.map{|n|n.name}).to eq(["n10name", "n11name"])
    expect(node9.is_begin_node?).to eq(false)
  end
end