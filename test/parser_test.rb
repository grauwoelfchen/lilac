require "test_helper"

class Lilac::ParserTest < Minitest::Unit::TestCase
  def test_parse_initializes_input_as_enumerator_lazy_lines
    parser = Lilac::Parser.new("* foo")
    assert_instance_of Enumerator::Lazy, parser.parse
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

  def test_handle_line_raises_error_for_invalid_too_many_indent
    # TODO
    # handle error
    parser = Lilac::Parser.new
    acc = []
    assert_raises NoMethodError do
      parser.handle_line("** foo", acc)
    end
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
end
