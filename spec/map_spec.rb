RSpec.describe EduGameMap::Map do
  it "hello" do
    map = EduGameMap::Map.create
    expect(map.json).to eq(nil)
  end
end