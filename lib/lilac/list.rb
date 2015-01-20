require "lilac/parser"
require "lilac/renderer"

module Lilac
  class List
    def initialize(text)
      @text = text
      @data = nil
    end

    def to_html
      parse! unless @data
      renderer = Lilac::Renderer.new(@data)
      renderer.render
    end

    private 

    def parse!
      parser = Lilac::Parser.new(@text)
      @data = parser.parse
    end
  end
end
