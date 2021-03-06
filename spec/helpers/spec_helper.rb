# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'minitest/hooks/default'

require 'pry' # for debugging

require 'factory_bot'
require_relative '../../init.rb'
require_relative '../factories/init'

USERNAME = 'soumyaray'
PROJECT_NAME = 'YPBT-app'
GH_URL = 'http://github.com/soumyaray/YPBT-app'
GITHUB_TOKEN = CodePraise::Api.config.GITHUB_TOKEN
CORRECT = YAML.safe_load(File.read('spec/fixtures/gh_results.yml'))

class Minitest::Spec
  include FactoryBot::Syntax::Methods
end
