require "test_helper"

class Lilac::RendererTest < Minitest::Test
  def test_render_returns_html_string
    data = [[:li, [:text, "foo"]]]
    renderer = Lilac::Renderer.new(data)
    assert_instance_of String, renderer.render
  end

  def test_renderer_raises_error_without_enumerable_data
    data = "invalid"
    renderer = Lilac::Renderer.new(data)
    assert_raises NoMethodError do
      renderer.render
    end
  end

  def test_render_appends_ul_tag
    data = [[:li, [:text, "foo"]]]
    renderer = Lilac::Renderer.new(data)
    expected = "<ul><li>foo</li></ul>"
    assert_equal expected, renderer.render
  end

  def test_build_ul_tag
    renderer = Lilac::Renderer.new
    expected = "<ul><li>foo</li></ul>"
    assert_equal expected, renderer.build(:ul, [[:li, [:text, "foo"]]])
  end

  def test_build_li_tag
    renderer = Lilac::Renderer.new
    expected = "<li>foo</li>"
    assert_equal expected, renderer.build(:li, [:text, "foo"])
  end

  def test_build_text_tag
    renderer = Lilac::Renderer.new
    expected = "foo"
    assert_equal expected, renderer.build(:text, "foo")
  end
end
