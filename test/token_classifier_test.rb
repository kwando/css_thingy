require 'test_helper'

class TokenClassifierTest < Minitest::Test
  def classifier
    @classifier = Tokenizer::TokenClassifier.new
  end

  def test_alpha_num?
    assert classifier.alpha_num?('A')
    assert classifier.alpha_num?('B')
    assert classifier.alpha_num?('a')
    assert classifier.alpha_num?('z')
    assert classifier.alpha_num?('_')
    assert classifier.alpha_num?('-')
    assert classifier.alpha_num?('2')
  end
end