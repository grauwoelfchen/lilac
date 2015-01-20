module Lilac
  class Renderer
    def initialize(data = nil)
      @data = data ? data : []
    end

    def render
      @data.inject("") { |acc, (t, b)|
        acc << build(t, b, 1)
        acc
      }.instance_eval { |rendered_list|
        "<ul>#{rendered_list}</ul>"
      }
    end

    private

    def build(tag, block, lv=1)
      case tag
      when :ul
        block.map { |t, b|
          build(t, b, lv)
        }.join.instance_eval { |li|
          "<ul>#{li}</ul>"
        }
      when :li
        case block.first
        when :text
          build(:text, "<li>" + block.last.to_s + "</li>")
        when :ul
          block.last.map { |t, b|
            build(t, b, lv + 1)
          }.join.instance_eval { |li|
            "<li><ul>#{li}</ul></li>"
          }
        end
      else # text
        block
      end
    end
  end
end
