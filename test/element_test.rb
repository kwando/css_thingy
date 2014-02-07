require 'test_helper'
require_relative '../main'

class ElementTest < Minitest::Test
  def setup
    @element = Element.new('button')
  end

  def test_classes
    css_class = 'success-button'

    assert !@element.has_class?(css_class)
    assert_kind_of Element, @element.add_class(css_class)
    @element.has_class?(css_class)

    assert_kind_of Element, @element.add_class(css_class)
    assert @element.has_class?(css_class)

    assert @element.remove_class(css_class)
    assert !@element.has_class?(css_class)
  end
end