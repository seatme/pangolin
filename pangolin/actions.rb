module Pangolin
  module Actions

    DSL_METHODS = [:click, :single_tap, :within_alert, :fill_in, :dismiss_popover]

    def click(*args)
      opts = args.last if args.last.kind_of?(Hash)

      if args.count.zero?
        mobile_tap opts[:x], opts[:y]
      else
        find(*args).tap(&:click)
      end
    end

    alias_method :single_tap, :click

    def within_alert(&block)
      alert = driver.switch_to.alert
      if (alert)
        yield alert
      else
        raise Pangolin::ElementNotFound.new("No alert found")
      end
    end

    def dismiss_popover
      mobile_tap(0.99, 0.99)

      wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
      wait.until { driver.find_elements(:tag_name, 'popover').empty?  }
    end

    #
    # Appium Mobile Extensions
    # 

    def mobile_tap(x, y)
      window = driver.find_element(:tag_name, 'window')
      driver.execute_script 'mobile: tap', :x => x, :y => y, :element => window.ref
    end

  end
end
