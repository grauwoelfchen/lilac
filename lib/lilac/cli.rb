require "lilac/list"

module Lilac
  class Cli
    def initialize(opts={}, text=nil)
      @list = Lilac::List.new(text)
    end

    def run
      puts @list.to_html
    end
  end
end
