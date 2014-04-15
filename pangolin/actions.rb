module Pangolin
  module Actions

    DSL_METHODS = [:click, :single_tap, :within_alert, :fill_in, :dismiss_popover]

    def click(*args)
      find(*args).tap(&:click)
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
  end

end
