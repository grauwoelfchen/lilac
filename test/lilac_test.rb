require "stringio"
require "test_helper"

class LilacTest < Minitest::Test
  def test_output_from_cli_input
    text = <<-TEXT.gsub(/^\s{4}/, "")
    * foo
    * bar
    * baz
    TEXT
    cli = Lilac::Cli.new({}, text)
    result = capture_stdout { cli.run }
    expected = <<-LIST.gsub(/\n|\s/, "")
    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
    LIST
    assert_equal expected, result
  end

  def capture_stdout
    origin = $stdout
    $stdout = StringIO.new
    yield
    result = $stdout.string.strip
    $stdout = origin
    result
  end
end
