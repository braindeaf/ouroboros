module Ouroboros
  class Array
    attr_reader :store

    def initialize(args = [])
      @store = ::Array.new(args)
    end

    def inspect
      "#{self.class.name}#{store}"
    end

    def [](*args)
      case args
      in ::Array[Range => range]
        send(:[], range.begin, range.size)

      in ::Array[Integer => start, Integer => length]
        base = store.rotate(start % store.size)
        times, remainder = length.divmod(store.size)
        self.class.new([*(base * times), *base[0, remainder]])

      in ::Array[Integer => index]
        at(index)

      else
        store.send(:[], *args).then { |o| o.is_a?(::Array) ? Array.new(o) : o }
      end
    end

    def ==(other)
      other == store
    end

    def at(index)
      store.at(index % store.size)
    end

    private

    def method_missing(m, *args, &block)
      store.send(m, *args, &block).then { |o| o.is_a?(::Array) ? Array.new(o) : o }
    end

    def respond_to_missing?(m, include_private = false)
      data.respond_to?(m, include_private)
    end
  end
end
