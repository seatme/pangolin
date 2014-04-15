
module Pangolin
  module RSpecMatchers

    class Matcher
      def initialize(locator)
        @locator = locator
      end
    end

    class HasViewMatcher < Matcher
      def matches?(actual)
        !!actual.find(@locator) rescue false
      end

      def does_not_match?(actual)
        actual.all(locator).size.zero?
      end

      def description
        "have view \"#{@locator}\""
      end

      def failure_message
        "Expected to have a visible view with name or label \"#{@locator}\""
      end

      def failure_message_when_negated
        failure_message.sub(/(to have)/, 'NOT \1')
      end
    end


    def have_view(locator, options={})
      HasViewMatcher.new(locator)
    end

  end
end


