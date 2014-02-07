require 'bundler'
Bundler.require
require 'minitest/autorun'


class SelectorTestCase < Minitest::Test
  def assert_match(selector, element)
    assert_respond_to selector, :matches?
    assert selector.matches?(element), proc{ "#{selector} should match #{element}" }
  end

  def assert_no_match(selector, element)
    assert_respond_to selector, :matches?
    assert !selector.matches?(element), proc{ "#{selector} should match #{element}" }
  end
end
