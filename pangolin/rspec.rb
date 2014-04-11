require 'rspec'
require_relative 'session'
require_relative 'matchers'
require_relative '../pangolin'

module Pangolin
  module ExampleHelpers
  
    def session
      Pangolin.session
    end

    def click(*args)
      session.click(*args)
    end

    def within_alert(&block)
      session.within_alert(&block)
    end

    def screen
      session
    end

  end
end


RSpec.configure do |c|
  c.include Pangolin::ExampleHelpers
  c.include Pangolin::RSpecMatchers

  c.after(:suite) { Pangolin.teardown_session! }
end

