require_relative 'appium'

#
# Attempt to auto-detect the path to a debug build of Dorsia for the simulator
# in the Xcode DerivedData dir.
#

XCODE_DERIVED_DATA = File.expand_path("Library/Developer/Xcode/DerivedData", Dir.home)
XCODE_APP_GLOB = "#{XCODE_DERIVED_DATA}/**/Debug-iphonesimulator/Dorsia.app"

def discover_app_path
  app_path = ENV['DUMBWAITER_APP_PATH']
  if !app_path || !File.file?(app_path) 
    app_path = Dir[XCODE_APP_GLOB].sort_by {|f| File.mtime(f) }.last
  end

  if app_path
    puts "Testing application executable #{app_path}\n\n"
    return app_path
  else
    puts "Application executable could not be found."
    puts "Please specify the full path to Dorsia.app (compiled for the simulator) using the DUMBWAITER_APP_PATH environment variable."
    exit
  end
end

APPIUM_CAPABILITIES = {
  'device' => 'ipad',
  'deviceName' => 'iPad',
  'browserName' => 'iOS',
  'platform' => 'Mac',
  #'version' => '7.0',
  'app' => discover_app_path
}


module Pangolin
  module Driver

    def driver
       @driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => APPIUM_CAPABILITIES, :url => APPIUM_URL) 
    end

    def teardown_driver!
      @driver.quit if @driver
      @driver = nil
    end

  end
end
