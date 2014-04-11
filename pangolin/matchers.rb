
module Pangolin
  module RSpecMatchers

    class Matcher
      def initialize(locator)
        @locator = locator
      end
    end

    class HasViewMatcher < Matcher
      def matches?(actual)
        !!actual.find(@locator)
      end

      def does_not_match?(actual)
        actual.all(locator).size.zero?
      end

      def description
        "have view \"#{@locator}\""
      end
    end


    def have_view(locator, options={})
      HasViewMatcher.new(locator)
    end

  end
end


