module Lilac
  class Parser
    def initialize(text = nil)
      @text = text ? text.each_line.lazy : []
    end

    def parse
      @text.inject([]) { |acc, line|
        line = handle_bullet(line)
        begin
          handle_line(line, acc)
        rescue
          # pass
        end
        acc
      }.lazy
    end

    private

    def handle_bullet(line)
      # md to adoc, -|+ to *
      line.gsub(/^(\s*)([\*\-\+]+)/) { |bullet|
        level = $1.to_s.length
        if level == 0 && $2 =~ /[\-\+]+/
          "*"
        elsif level > 1
          "*" * (level / 2 + 1)
        else
          bullet.gsub(/-/, "*")
        end
      }
    end

    # TODO
    #   * remove magic number
    #   * remove destructive method to reference
    def handle_line(line, acc)
      if line =~ /^(\*+)\s/
        level = $1.length
        text  = line.gsub($1, "")
        if level == 1
          acc << [:li, [handle_text(text)]]
        elsif !acc.empty?
          cur = ul = acc
          # progression
          #   **    ->  1
          #   ***   ->  5
          #   ****  ->  9
          #   ***** -> 13
          inspection = 1 + (4 * (level - 2))
          inspection.times { cur = cur.last if cur }
          case cur.first
          when :ul
            cur.last << [:li, [handle_text(text)]]
          else
            sib = nil
            begin; sib = cur.last.last.last.last; rescue NoMethodError; end
            if sib && sib.first == :li
              # apeend as siblings
              cur = cur.last.last
              cur[-1] += [[:li, [handle_text(text)]]]
            else
              # nest
              cur[-1] += [[:ul, [[:li, [handle_text(text)]]]]]
            end
          end
        end
      end
    end

    def handle_text(line)
      [:text, line.strip.chomp.gsub(/^\s*/, "")]
    end
  end
end
