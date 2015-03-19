module Lilac
  class Renderer
    def initialize(data = nil)
      @data = data ? data : []
    end

    def render
      build(:ul, @data)
    end

    private

    def build(tag, block)
      wrap(tag, block.inject("") { |acc, elems|
        acc << elems.each_cons(2).map { |t, b|
          t == :text ? b : build(t, b)
        }.join
        acc
      })
    end

    def wrap(tag, content)
      case tag
      when :ul ; "<ul>#{content}</ul>"
      when :li ; "<li>#{content}</li>"
      else # pass
      end
    end
  end
end
