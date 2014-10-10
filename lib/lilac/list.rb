require "lilac/parser"
require "lilac/renderer"

module Lilac
  class List
    attr_accessor :list

    def initialize(list)
      @list = list
      @data = nil
    end

    def parse
      parser = Lilac::Parser.new(@list)
      @data = parser.parse
    end

    def to_html
      parse unless @data
      renderer = Lilac::Renderer.new(@data)
      renderer.render
    end
  end
end
