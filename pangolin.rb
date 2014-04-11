require_relative 'pangolin/session'
require_relative 'pangolin/simulator'

module Pangolin

  class << self
    attr_accessor :default_wait_time, :session

    def session
      @session ||= Pangolin::Session.new
    end

    def teardown_session!
      @session.teardown! if @session
      @session = nil
    end
  end

end

at_exit { Pangolin.teardown_session! }
trap("INT")  { Pangolin.teardown_session! }
trap("QUIT") { Pangolin.teardown_session! }
trap("ABRT") { Pangolin.teardown_session! }
trap("TERM") { Pangolin.teardown_session! }

