
module Pangolin

  module Simulator

    class << self
      def quit!
        system "killall 'iPhone Simulator'"      
      end
    end

  end

end
