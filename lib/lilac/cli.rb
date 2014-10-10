require "lilac/list"

module Lilac
  class Cli
    def initialize(opts={}, list=nil)
      @list = Lilac::List.new(list)
    end

    def run
      puts @list.to_html
    end
  end
end
