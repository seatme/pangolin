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

  end
end

