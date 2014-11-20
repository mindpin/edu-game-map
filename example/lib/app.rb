require "mongoid"
require "./lib/course"
require "./lib/lesson"

ENV["RACK_ENV"] ||= "development"

Mongoid.load!("./mongoid.yml")
