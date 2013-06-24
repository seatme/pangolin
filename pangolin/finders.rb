module Pangolin

  class ElementNotFound < StandardError
  end

  module Finders
    def all(locator)
      driver.find_elements(:name, locator)
    end

    def find(locator)
      keep_trying do
        result = all(locator)

        if result.size == 0
          raise Pangolin::ElementNotFound.new("Unable to find element '#{locator}'")
        end

        result.first
      end
    end
  end

end
