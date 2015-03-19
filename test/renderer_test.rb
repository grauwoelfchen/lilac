require "test_helper"

class Lilac::RendererTest < Minitest::Test
  def test_should_raise_error_without_enumerable_data
    data = "invalid"
    renderer = Lilac::Renderer.new(data)
    assert_raises(NoMethodError) do
      renderer.render
    end
  end

  def test_should_wrap_rendered_list_with_ul_tag
    data = [[:li, [[:text, "bar"]]]]
    renderer = Lilac::Renderer.new(data)
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>bar</li>
      </ul>
    HTML
    assert_equal(expected, renderer.render)
  end

  # build

  def test_should_build_text_tag
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <li>foo</li>
    HTML
    block = [
      [:text, "foo"]
    ]
    assert_equal(expected, renderer.send(:build, :li, block))
  end

  def test_should_build_li_tag
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>foo</li>
      </ul>
    HTML
    block = [
      [:li, [
        [:text, "foo"]
      ]]
    ]
    assert_equal expected, renderer.send(:build, :ul, block)
  end

  def test_should_build_multiple_li_tags
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>foo</li>
        <li>bar</li>
      </ul>
    HTML
    block = [
      [:li, [
        [:text, "foo"]
      ]],
      [:li, [
        [:text, "bar"]
      ]]
    ]
    assert_equal expected, renderer.send(:build, :ul, block)
  end

  def test_should_build_ul_tag
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>
          <ul>foo</ul>
        </li>
      </ul>
    HTML
    block = [
      [:li, [
        [:ul, [
          [:text, "foo"]
        ]]
      ]]
    ]
    assert_equal(expected, renderer.send(:build, :ul, block))
  end

  def test_should_build_nested_ul_tag
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>foo
          <ul>
            <li>bar</li>
          </ul>
        </li>
      </ul>
    HTML
    block = [
      [:li, [
        [:text, "foo"],
        [:ul, [
          [:li, [
            [:text, "bar"]]]
        ]]
      ]]
    ]
    assert_equal(expected, renderer.send(:build, :ul, block))
  end

  def test_should_build_deep_nested_ul_tag
    renderer = Lilac::Renderer.new
    expected = <<-HTML.gsub(/^\s*|\n/, "")
      <ul>
        <li>foo</li>
        <li>bar
          <ul>
            <li>baz</li>
            <li>qux
              <ul>
                <li>quux</li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    HTML
    block = [
      [:li, [[:text, "foo"]]],
      [:li, [
        [:text, "bar"],
        [:ul, [
          [:li, [[:text, "baz"]]],
          [:li, [
            [:text, "qux"],
            [:ul, [
              [:li, [[:text, "quux"]]]
            ]]
          ]]
        ]]
      ]]
    ]
    assert_equal(expected, renderer.send(:build, :ul, block))
  end
end
