# Selector base class
class Selector
  def matches?(element)
    false
  end
end

# # # # # # # # # # # # # # # # # # # #
# Example selectors
# # # # # # # # # # # # # # # # # # # #
class AlwaysSelector
  def matches?(element)
    true
  end
end
class TagSelector
  def initialize(tag_name)
    @tag_name = tag_name
  end

  def matches?(element)
    element.tag_name == @tag_name
  end

  def to_s
    @tag_name
  end

  def ==(selector)
    @tag_name == selector.to_s
  end
end

class ClassSelector
  def initialize(css_class)
    @css_class = css_class
  end

  def matches?(element)
    element.has_class?(@css_class)
  end

  def to_s
    ".#{@css_class}"
  end

  def ==(selector)
    to_s == selector.to_s
  end
end

class CombinedSelector < TagSelector
  def initialize(*args)
    @selectors = []
    args.each do |s|
      add_selector(s)
    end
  end

  def add_selector(selector)
    @selectors << selector
    self
  end

  def to_s
    selectors.map{|s| s.to_s }.join
  end

  protected
  def selectors
    @selectors
  end
end

class ParentSelector
  def initialize(selector)
    @selector = selector
  end

  def matches?(element)
    element.has_parent? && selector.matches?(element.parent)
  end
end

class AncestorSelector
  def initialize(selector)
    @selector = selector
  end

  def matches?(element)
    while element.has_parent?
      return true if @selector.matches?(element.parent)
      element = element.parent
    end
    return false
  end
end

class AllSelector < CombinedSelector
  def matches?(element)
    selectors.all?{|selector| selector.matches?(element) }
  end

  def merge(all_selector)
    raise TypeError unless all_selector.kind_of?(AllSelector)
    all_selector.selectors.each do |s|
      add_selector(s)
    end
  end
end

class AnySelector < CombinedSelector
  def matches?(element)
    selectors.any?{|selector| selector.matches?(element) }
  end
end


class Stylesheet
  def initialize
    @rules = []
  end

  def add_rule(selector, rules)
    @rules << [selector, rules]
    self
  end

  # collection all rules for an element
  def collect_rules(element, styles)
    @rules.each do |selector, rules|
      styles.add(rules) if selector.matches?(element)
    end
    return styles
  end
end