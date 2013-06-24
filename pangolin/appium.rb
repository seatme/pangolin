require 'tcpsocket-wait'

#
# Appium configuration
#

APPIUM_HOST = '127.0.0.1'
APPIUM_PORT = 4723
APPIUM_URL = "http://#{APPIUM_HOST}:#{APPIUM_PORT}/wd/hub"

APPIUM_PATH = %x(which appium).chomp
unless APPIUM_PATH.length > 0
  puts "Error: unable to locate 'appium'.  Make sure the npm/bin dir is in your path and try again."
  puts
  exit(4)
end

module Pangolin
  module Appium

    class <<self

      def start!
        print "Launching Appium (#{APPIUM_PATH})..."

        @appium_pid = spawn("#{APPIUM_PATH} -p #{APPIUM_PORT} 1>>./appium.log 2>&1")
        Process.detach(@appium_pid)

        print "\nWaiting for Appium server on port #{APPIUM_PORT}..."

        begin
          TCPSocket.wait_for_service_with_timeout :host => APPIUM_HOST, :port => APPIUM_PORT, :timeout => 10
        rescue SocketError => e
          puts "failed!"
          puts "Check appium.log and appium_console.log to see why Appium failed to launch."
          puts

          Process.kill("TERM", @appium_pid) rescue nil
          exit(5)
        end

        puts "ready!"
        puts
      end

      def stop!
        return unless @appium_pid

        puts
        print "Stopping Appium..."

        Process.kill("TERM", @appium_pid) rescue nil
        @appium_pid = nil

        print "done\n"
      end

    end

  end
end
