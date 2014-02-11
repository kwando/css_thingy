require 'test_helper'

class ParserTest < Minitest::Test
  def parser
    @parser ||= Parser.new
  end

  def test_parse_all
    result = parser.parse_all('button')

    assert_equal TagSelector.new('button'), result

    result = parser.parse_all('.button')
    assert_equal ClassSelector.new('button'), result


    selector = parser.parse_all('button.success.large')

    puts selector.inspect

    button = Element.new('button')
    button.add_class('success')

    assert !selector.matches?(button)

    button.add_class('large')
    assert selector.matches?(button)
  end
end