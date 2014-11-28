ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.setup(:default)
require "mongoid"
require "edu-game-map"
require "sinatra"

require "./lib/init"

require "./lib/course"
require "./lib/lesson"

user = User.find_or_create_by(:name => "user")

get "/minicourses" do
  content_type :json

  Course.find_by(:name => "Android开发").lessons.map(&:minicourse).to_json
end

get "/maps/:id" do
  content_type :json

  EduGameMap::Map.find_by(:map_id => params[:id]).json
end

get "/maps/:id/learn_record" do
  content_type :json

  map = EduGameMap::Map.find_by(:map_id => params[:id])
  map.map_learned_records.find_or_create_by(:user_id => user.id).json
end

put "/maps/:id/learn" do
  content_type :json

  if !params[:node_id]
    status 400

    return {:ok => false}.to_json
  end

  map = EduGameMap::Map.find_by(:map_id => params[:id])
  node = map.nodes.find {|node| node.id == params[:node_id]}

  node.do_learn_by(user)

  {:ok => true}.to_json
end

put "/maps/:id" do
  content_type :json

  map = EduGameMap::Map.find_by(:map_id => params[:id])
  map.json = params[:json]
  map.save

  map.json
end
