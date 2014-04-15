module Pangolin

  class ElementNotFound < StandardError
  end

  module Finders

    INPUT_FIELD_TAGS = ['textfield', 'textview']
    DEFAULT_FIND_OPTIONS = {:count => 1}

    def elements_by_name(locator)
      driver.find_elements(:name, locator)
    end

    def find(locator, opts={})
      raise AgumentError, "Argument locator is required" unless locator
      opts = DEFAULT_FIND_OPTIONS.merge(opts)

      keep_trying do
        results = elements_by_name(locator)

        unless results.size == opts[:count]
          raise Pangolin::ElementNotFound.new("Expected #{opts[:count]} element(s) matching \"#{locator}\", but found #{results.size}")
        end

        opts[:count] == 1 ? results[0] : results
      end
    end

    def find_input(locator)
      raise AgumentError, "Argument locator is required" unless locator

      element = find(locator)
      return element if INPUT_FIELD_TAGS.include?(element.tag_name)

      INPUT_FIELD_TAGS.each do |input_tag_name|
        fields = element.find_elements(:tag_name, input_tag_name)
        return fields[0] if fields and fields.count > 0
      end

      raise Pangolin::ElementNotFound, "No input-capable element found (types #{INPUT_FIELD_TAGS}) for locator \"#{locator}\""
    end


    private 

    def keep_trying(seconds=20, &block)
      Selenium::WebDriver::Wait.new(
        :timeout => seconds, 
        :ignore => Pangolin::ElementNotFound
      ).until(&block)
    end

  end
end
