require_relative 'appium'
require_relative 'driver'
require_relative 'finders'
require_relative 'actions'

module Pangolin

  class Session
    include Driver
    include Finders
    include Actions

    def initialize
      Appium.start!
    end

    def teardown!
      teardown_driver!
      Appium.stop!
      Simulator.quit!
    end

    def keep_trying(seconds=20)
      start_time = Time.now

      if @synchronized
        yield
      else
        @synchronized = true
        begin
          yield
        rescue => e
          raise e if (Time.now - start_time) >= seconds
          sleep(0.1)
          retry
        ensure
          @synchronized = false
        end
      end
    end
  end

end

