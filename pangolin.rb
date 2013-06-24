require_relative 'pangolin/session'
require_relative 'pangolin/simulator'

module Pangolin

  class << self
    attr_accessor :default_wait_time, :current_session

    def teardown_session!
      current_session.teardown! if current_session
      current_session = nil
    end
  end

end

at_exit { Pangolin.teardown_session! }
trap("INT")  { Pangolin.teardown_session! }
trap("QUIT") { Pangolin.teardown_session! }
trap("ABRT") { Pangolin.teardown_session! }
trap("TERM") { Pangolin.teardown_session! }

