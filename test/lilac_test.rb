require "test_helper"

class LilacTest < Minitest::Test
  def test_flat_list_creation
    text = <<-TEXT.gsub(/^\s*/, "")
    * foo
    * bar
    * baz
    TEXT
    list = Lilac::List.new(text)
    expected = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
    LIST
    assert_equal expected, list.to_html
  end

  def test_2_level_depth_list_creation
    text = <<-TEXT.gsub(/^\s*/, "")
    * foo
    ** bar
    ** baz
    TEXT
    list = Lilac::List.new(text)
    rendered = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>
        <ul>
          <li>bar</li>
          <li>baz</li>
        </ul>
      </li>
    </ul>
    LIST
    assert_equal rendered, list.to_html
  end

  def test_3_level_depth_list_creation
    text = <<-TEXT.gsub(/^\s*/, "")
    * foo
    ** bar
    *** baz
    TEXT
    list = Lilac::List.new(text)
    rendered = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>
        <ul>
          <li>bar</li>
          <li>
            <ul>
              <li>baz</li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
    LIST
    assert_equal rendered, list.to_html
  end
end
