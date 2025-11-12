module Ouroboros
  module CoreExt
    module Array
      def to_ouroboros
        Ouroboros::Array.new(self)
      end
    end
  end
end

::Array.include(Ouroboros::CoreExt::Array)
