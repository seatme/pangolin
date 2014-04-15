require 'rspec'
require_relative 'session'
require_relative 'matchers'
require_relative '../pangolin'

module Pangolin
  module RSpecDSL
  
    def session
      Pangolin.session
    end

    alias_method :screen, :session

    Pangolin::Session::DSL_METHODS.each do |method|
      define_method method do |*args, &block|
        session.send method, *args, &block
      end
    end

  end
end


RSpec.configure do |c|
  c.include Pangolin::RSpecDSL
  c.include Pangolin::RSpecMatchers

  c.after(:suite) { Pangolin.teardown_session! }
end

