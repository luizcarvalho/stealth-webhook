# coding: utf-8
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'pry'

require 'stealth-webhook'

RSpec.configure do |config|
  ENV['STEALTH_ENV'] = 'test'
end
