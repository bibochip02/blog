require "shoulda/matchers"
require 'active_support'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'simplecov'
require 'simplecov-lcov'
require 'simplecov-cobertura'
require 'coveralls'
require 'simplecov-json'
