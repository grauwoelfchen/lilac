module Lilac
  class Renderer
    def initialize(data = nil)
      @data = data ? data : []
    end

    def render
      @data.inject("") { |acc, (t, b)|
        acc << build(t, b, 1)
        acc
      }.instance_eval { |rendered|
        "<ul>#{rendered}</ul>"
      }
    end

    def build(tag, block, lv=1)
      case tag
      when :ul
        block.map { |t, b|
          build(t, b, lv)
        }.join.instance_eval { |rendered|
          "<ul>#{rendered}</ul>"
        }
      when :li
        case block.first
        when :text
          build(:text, "<li>" + block.last.to_s + "</li>")
        when :ul
          block.last.map { |t, b|
            build(t, b, lv + 1)
          }.join.instance_eval { |rendered|
            "<li><ul>#{rendered}</ul></li>"
          }
        end
      else # text
        block
      end
    end
  end
end
