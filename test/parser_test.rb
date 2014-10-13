require "test_helper"

class Lilac::ParserTest < Minitest::Unit::TestCase
  def test_parse_initializes_input_as_enumerator_lazy_lines
    parser = Lilac::Parser.new("* foo")
    assert_instance_of Enumerator::Lazy, parser.parse
  end

  def test_handle_bullet_replacel_hyphen_as_asterisk
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.handle_bullet("- foo")
  end

  def test_handle_bullet_removes_asciidoc_hyphen_indent
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.handle_bullet("--- foo")
  end

  def test_handle_bullet_does_not_replace_invalid_indent
    parser = Lilac::Parser.new
    assert_equal " * foo", parser.handle_bullet(" * foo")
  end

  def test_handle_bullet_keeps_no_indent_asterisk_bullet
    parser = Lilac::Parser.new
    assert_equal "* foo", parser.handle_bullet("* foo")
  end

  def test_handle_bullet_replaces_indent_by_2_spaces_as_2_asterisks
    parser = Lilac::Parser.new
    assert_equal "** foo", parser.handle_bullet("  * foo")
  end

  def test_handle_bullet_replaces_indent_by_4_spaces_as_3_asterisks
    parser = Lilac::Parser.new
    assert_equal "*** foo", parser.handle_bullet("    * foo")
  end

  def test_handle_line_ignores_line_without_be_started_with_asterisk_bullet
    parser = Lilac::Parser.new
    acc = []
    parser.handle_line("- foo", acc)
    assert_equal [], acc
  end

  def test_handle_line_ignores_line_without_whitespace_after_bullet
    parser = Lilac::Parser.new
    acc = []
    parser.handle_line("*foo", acc)
    assert_equal [], acc
  end

  def test_handle_line_ignores_too_many_indented_line
    parser = Lilac::Parser.new
    acc = []
    parser.handle_line("** foo", acc)
    assert_equal [], acc
  end

  def test_handle_line_extracts_valid_1_level_depth_line
    parser = Lilac::Parser.new
    acc = []
    parser.handle_line("* foo", acc)
    expected = [
      [:li, [:text, "foo"]]
    ]
    assert_equal expected, acc
  end

  def test_handle_line_extracts_valid_1_level_depth_multiple_lines
    parser = Lilac::Parser.new
    acc = [[:li, [:text, "foo"]]]
    parser.handle_line("* bar", acc)
    expected = [
      [:li, [:text, "foo"]],
      [:li, [:text, "bar"]]
    ]
    assert_equal expected, acc
  end

  def test_handle_line_extracts_valid_2_level_depth_lines
    parser = Lilac::Parser.new
    acc = [[:li, [:text, "foo"]]]
    parser.handle_line("** bar", acc)
    expected = [
      [:li, [:text, "foo"]],
      [:li, [:ul, [
        [:li, [:text, "bar"]]
      ]]]
    ]
    assert_equal expected, acc
  end

  def test_handle_line_extracts_valid_3_level_depth_lines
    parser = Lilac::Parser.new
    acc = [
      [:li, [:text, "foo"]],
      [:li, [:ul, [
        [:li, [:text, "bar"]]]]
      ]
    ]
    parser.handle_line("*** baz", acc)
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

  def test_handle_text_removes_line_break
    parser = Lilac::Parser.new
    assert_equal [:text, "foo"], parser.handle_text("foo\n")
  end

  def test_handle_text_removes_whitespaces_in_both_side
    parser = Lilac::Parser.new
    assert_equal [:text, "foo"], parser.handle_text(" foo \n")
  end
end
