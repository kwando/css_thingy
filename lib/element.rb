class Element
  def initialize(tag_name)
    @tag_name = tag_name
    @classes = []
    @parent = nil
  end

  def tag_name
    @tag_name
  end

  def has_parent?
    !@parent.nil?
  end

  def parent
    @parent
  end

  def parent=(element)
    @parent = element
  end

  def add_class(css_class)
    @classes << css_class
    self
  end

  def remove_class(css_class)
    @classes.delete(css_class)
    self
  end

  def has_class?(css_class)
    @classes.include?(css_class)
  end

  def classes
    @classes
  end

  def to_s
    %Q(<#{tag_name}></#{@tag_name})
  end
end