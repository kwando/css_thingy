class Tokenizer
  class TokenClassifier
    def space?(s)
      s == ' ' || s == "\t"
    end

    def alpha_num?(s)
      s =~/[A-Za-z0-9_-]/
    end
  end

  def initialize(input)
    @input = input.to_s
    @at = input.length
    @classifier = TokenClassifier.new
  end

  def empty?
    @at <= 0
  end

  def remove_space
    until empty? || !@classifier.space?(@input[@at-1])
      @at -= 1
    end
  end

  def peek
    @input[@at-1]
  end

  def pop
    @input[@at-1].tap do
      @at -= 1
    end
  end

  def ident
    i = @at - 1
    while @at > 0 && @classifier.alpha_num?(at(@at-1))
      @at -= 1
    end
    @input[(@at)..i]
  end

  def at(n)
    @input[n]
  end

  def space?
    @classifier.space?(at(@at-1))
  end

  def remains
    @input[0..(@at-1)]
  end
end

class Parser
  def parse(selector)
    selector = selector.strip
    raise 'cannot be empty' if selector.empty?
    parse_ancestor(selector)
  end

  def parse_ancestor(input)
    splits = input.split(/\s+/)
    if splits.size == 1
      parse_all(input)
    else
      selector = AllSelector.new
      last = splits.pop
      splits.each do |split|
        selector.add_selector(AncestorSelector.new(parse_all(split)))
      end
      selector.add_selector(parse_all(last))
      return selector
    end
  end

  def parse_all(input)
    tokenizer = Tokenizer.new(input)
    tokenizer.remove_space
    raise 'ParseError' if tokenizer.empty?

    return AlwaysSelector.new if tokenizer.peek == '*'

    identifier = tokenizer.ident
    raise 'ParseError, no identifier' if identifier.size == 0

    return TagSelector.new(identifier) if tokenizer.empty?

    selector = nil
    case tokenizer.pop
      when '.' then
        selector = ClassSelector.new(identifier)
    end

    raise 'ParseError' if selector.nil?
    return selector if tokenizer.empty?
    s2 = parse_all(tokenizer.remains)
    if s2.kind_of?(AllSelector)
      s2.add_selector(selector)
    else
      AllSelector.new(selector, s2)
    end
  end
end
