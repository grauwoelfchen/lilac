require "test_helper"

class Lilac::ParserTest < Minitest::Test
  def test_should_returns_enumerator_lazy_object
    parser = Lilac::Parser.new("* foo")
    assert_instance_of Enumerator::Lazy, parser.parse
  end

  def test_should_replace_hyphen_as_asterisk
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.send(:handle_bullet, "- foo")
  end

  def test_should_remove_asciidoc_hyphen_indent
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.send(:handle_bullet, "--- foo")
  end

  def test_should_not_replace_invalid_indent
    parser = Lilac::Parser.new
    assert_equal " * foo", parser.send(:handle_bullet, " * foo")
  end

  def test_should_keep_asterisk_bullet_without_indent
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.send(:handle_bullet, "* foo")
  end

  def test_should_replace_indent_by_2_spaces_as_2_asterisks
    parser = Lilac::Parser.new
    assert_equal "** foo", parser.send(:handle_bullet, "  * foo")
  end

  def test_should_replace_indent_of_4_spaces_as_3_asterisks
    parser = Lilac::Parser.new
    assert_equal "*** foo", parser.send(:handle_bullet, "    * foo")
  end

  def test_should_ignore_line_without_be_not_started_with_asterisk_bullet
    parser = Lilac::Parser.new
    acc = []
    parser.send(:handle_line, "- foo", acc)
    assert_equal [], acc
  end

  def test_should_ignore_line_without_whitespace_after_bullet
    parser = Lilac::Parser.new
    acc = []
    parser.send(:handle_line, "*foo", acc)
    assert_equal [], acc
  end

  def test_should_ignore_line_that_has_too_many_bullets
    parser = Lilac::Parser.new
    acc = []
    parser.send(:handle_line, "** foo", acc)
    assert_equal [], acc
  end

  def test_should_extract_valid_1_level_depth_line
    parser = Lilac::Parser.new
    acc = []
    parser.send(:handle_line, "* foo", acc)
    expected = [
      [:li, [:text, "foo"]]
    ]
    assert_equal expected, acc
  end

  def test_should_extract_valid_1_level_depth_multiple_lines
    parser = Lilac::Parser.new
    acc = [[:li, [:text, "foo"]]]
    parser.send(:handle_line, "* bar", acc)
    expected = [
      [:li, [:text, "foo"]],
      [:li, [:text, "bar"]]
    ]
    assert_equal expected, acc
  end

  def test_should_extract_valid_2_level_depth_lines
    parser = Lilac::Parser.new
    acc = [[:li, [:text, "foo"]]]
    parser.send(:handle_line, "** bar", acc)
    expected = [
      [:li, [:text, "foo"]],
      [:li, [:ul, [
        [:li, [:text, "bar"]]
      ]]]
    ]
    assert_equal expected, acc
  end

  def test_should_extract_valid_3_level_depth_lines
    parser = Lilac::Parser.new
    acc = [
      [:li, [:text, "foo"]],
      [:li, [:ul, [
        [:li, [:text, "bar"]]]]
      ]
    ]
    parser.send(:handle_line, "*** baz", acc)
    expected = [
      [:li, [:text, "foo"]],
      [:li, [:ul, [
        [:li, [:text, "bar"]],
        [:li, [:ul, [
          [:li, [:text, "baz"]]
        ]]]
      ]]]
    ]
    assert_equal expected, acc
  end

  def test_should_remove_line_break
    parser = Lilac::Parser.new
    assert_equal [:text, "foo"], parser.send(:handle_text, "foo\n")
  end

  def test_should_remove_whitespaces_in_both_side
    parser = Lilac::Parser.new
    assert_equal [:text, "foo"], parser.send(:handle_text, " foo \n")
  end
end
