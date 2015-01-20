require "test_helper"

class MarkdownTest < Minitest::Unit::TestCase
  def test_asterisk_bullet_flat_list
    text = <<-TEXT.gsub(/^\s{4}/, "")
    * foo
    * bar
    * baz
    TEXT
    expected = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
    LIST
    list = Lilac::List.new(text)
    assert_equal expected, list.to_html
  end

  def test_hyphen_bullet_flat_list
    text = <<-TEXT.gsub(/^\s{4}/, "")
    - foo
    - bar
    - baz
    TEXT
    expected = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
    LIST
    list = Lilac::List.new(text)
    assert_equal expected, list.to_html
  end

  def test_plus_bullet_flat_list
    text = <<-TEXT.gsub(/^\s{4}/, "")
    + foo
    + bar
    + baz
    TEXT
    expected = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
    LIST
    list = Lilac::List.new(text)
    assert_equal expected, list.to_html
  end


  def test_asterisk_bullet_2_level_depth_list
    text = <<-TEXT.gsub(/^\s{4}/, "")
    * foo
      * bar
      * baz
    TEXT
    expected = <<-LIST.gsub(/\n|\s/, "")
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
    list = Lilac::List.new(text)
    assert_equal expected, list.to_html
  end

  def test_asterisk_bullet_3_level_depth_list_creation
    text = <<-TEXT.gsub(/^\s{4}/, "")
    * foo
      * bar
        * baz
    TEXT
    expected = <<-LIST.gsub(/\n|\s/, "")
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
    list = Lilac::List.new(text)
    assert_equal expected, list.to_html
  end
end
