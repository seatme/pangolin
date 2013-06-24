require 'rspec'
require_relative 'session'
require_relative '../pangolin'

module Pangolin
  module ExampleHelpers
  
    def session
      Pangolin.current_session ||= Pangolin::Session.new
    end

    def session=(session)
      Pangolin.current_session = session
    end

    def click(*args)
      session.click(*args)
    end

    def within_alert(&block)
      session.within_alert(&block)
    end

  end
end


RSpec.configure do |c|
  c.include Pangolin::ExampleHelpers
  c.after(:suite) { Pangolin.teardown_session! }
end

