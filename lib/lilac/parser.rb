module Lilac
  class Parser
    def initialize(list = nil)
      @list = list ? list.each_line.lazy : []
    end

    def parse
      @list.inject([]) { |acc, line|
        line = handle_bullet(line)
        begin
          handle_line(line, acc)
        rescue
        end
        acc
      }.lazy
    end

    def handle_bullet(line)
      # md to adoc, - to *
      line.gsub(/^(\s*)([\*-]+)/) { |bullet|
        level = $1.to_s.length
        if level == 0 && $2 =~ /-+/
          "*"
        elsif level > 1
          "*" * (level / 2 + 1)
        else
          bullet.gsub(/-/, "*")
        end
      }
    end

    def handle_line(line, acc)
      if line =~ /^(\*+)\s/
        level = $1.length
        text  = line.gsub($1, "")
        if level == 1
          acc << [:li, handle_text(text)]
        elsif !acc.empty?
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
