require "test_helper"

class Lilac::ListTest < Minitest::Test
  def test_should_returns_string
    list = Lilac::List.new("* foo\n")
    assert_instance_of String, list.to_html
  end

  def test_should_prepare_parsed_data
    list = Lilac::List.new("* foo\n")
    list.send(:parse!)
    assert_instance_of Enumerator::Lazy, list.instance_variable_get(:@data)
  end
end
