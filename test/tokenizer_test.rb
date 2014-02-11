require 'test_helper'

class TokenizerTest < Minitest::Test
  def test_id
    t = Tokenizer.new('')
    assert t.empty?

    t = Tokenizer.new('button')
    assert !t.empty?

    t = Tokenizer.new('   ')
    assert !t.empty?

    t.remove_space

    assert t.empty?
  end

  def test_peek
    t = Tokenizer.new('button')
    assert_equal 'n', t.peek

    t = Tokenizer.new('button  ')
    assert_equal ' ', t.peek

    t.remove_space
    assert_equal 'n', t.peek

    t = Tokenizer.new('')
    assert_equal nil, t.peek
  end

  def test_pop
    t = Tokenizer.new('button')
    assert_equal 'n', t.peek

    t = Tokenizer.new('button  ')
    assert_equal ' ', t.peek

    t.remove_space
    assert_equal 'n', t.peek
  end

  def test_ident
    t = Tokenizer.new('button')
    assert_equal 'button', t.ident

    t = Tokenizer.new('button ')
    assert_equal "", t.ident

    t = Tokenizer.new('body button')
    assert_equal 'button', t.ident
    t.remove_space
    assert_equal 'body', t.ident
  end

  def test_space?
    t = Tokenizer.new('')
    assert !t.space?

    t = Tokenizer.new(' ')
    assert t.space?

    t = Tokenizer.new('body button')
    t.ident
    assert t.space?
    t.remove_space
    assert !t.space?
  end

  def test_remains
    t = Tokenizer.new('button.success')
    assert_equal 'button.success', t.remains
    t.ident
    t.pop
    assert_equal t.remains, 'button'
  end
end