ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.setup(:default)
require "mongoid"
require "edu-game-map"
require "sinatra"

require "./lib/init"

require "./lib/course"
require "./lib/lesson"


get "/minicourses" do
  content_type :json

  EduGameMap::Minicourse.all.to_json
end

post "/maps" do
  content_type :json

  map = EduGameMap::Map.create
  map.json = params[:json]
  map.save

  map.json_hash.to_json
end

put "/maps/:id" do
  content_type :json

  map = EduGameMap::Map.find(params[:id])
  map.json = params[:json]
  map.save

  map.json_hash.to_json
end
