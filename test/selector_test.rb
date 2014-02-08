require 'test_helper'
require_relative '../main'


class SelectorTest < SelectorTestCase
  def test_tagselector
    elem = Element.new('div')
    elem.add_class('button')

    assert_match TagSelector.new('div'), elem
    assert_no_match TagSelector.new('button'), elem
  end

  def test_class_selector
    elem = Element.new('div')
    elem.add_class('success-button')

    assert_match ClassSelector.new('success-button'), elem
    assert_no_match ClassSelector.new('danger-button'), elem
  end

  def test_combined_selector
    elem = Element.new('div')
    elem.add_class('success-button')
    elem.add_class('danger-button')

    selector = AllSelector.new(TagSelector.new('div'), ClassSelector.new('success-button'))

    assert_match selector, elem
  end


  def test_ancestor_selector
    div = Element.new('div')
    div.add_class('success')

    button = Element.new('button')
    button.parent = div

    selector = AllSelector.new(AncestorSelector.new(TagSelector.new('div')), TagSelector.new('button'))

    assert_match selector, button
  end
end