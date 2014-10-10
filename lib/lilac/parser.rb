module Lilac
  class Parser
    def initialize(list = nil)
      @list = list ? list.each_line.lazy : []
    end

    def parse
      @list.inject([]) { |acc, line|
        handle_line(line, acc)
        acc
      }.lazy
    end

    def handle_line(line, acc)
      if line =~ /^(\*+)\s/
        level = $1.length
        text  = line.gsub($1, "")
        if level == 1
          acc << [:li, handle_text(text)]
        else
          cur = ul = acc
          # progression
          #   **    -> 2
          #   ***   -> 5
          #   ****  -> 8
          #   ***** -> 11
          inspection = level * 3 - 4
          inspection.times { cur = cur.last if cur }
          case cur.first
          when :ul
            cur.last << [:li, handle_text(text)]
          else
            # current ul
            (inspection - 2).times { ul = ul.last }
            ul << [:li, [:ul, [[:li, handle_text(text)]]]]
          end
        end
      end
    end

    def handle_text(line)
      [:text, line.strip.chomp.gsub(/^\s*/, "")]
    end
  end
end
