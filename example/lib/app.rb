require "bundler"
Bundler.setup(:default)
require "mongoid"
require "edu-game-map"
require "sinatra"

require "./lib/course"
require "./lib/lesson"

ENV["RACK_ENV"] ||= "development"

Mongoid.load!("./mongoid.yml")

get "/json" do
  content_type :json

  {}.to_json
end
