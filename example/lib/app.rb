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
