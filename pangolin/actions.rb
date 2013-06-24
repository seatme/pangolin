module Pangolin

  module Actions
    def click(*args)
      find(*args).tap(&:click)
    end

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
