module ColorTheory
  class Spectrum
    def initialize(first, last, exclusive = false)
      @first, @last, @exclusive = first, last, exclusive
    end

    def begin
      @first
    end
    alias :first :begin

    def end
      @last
    end
    alias :last :end

    def exclude_end?
      @exclusive
    end

    def ==(other)
      other.is_a?(Spectrum) &&
        self.begin == other.begin &&
        self.end == other.end &&
        self.exclude_end? == other.exclude_end?
    end

    def ===(color)
      excluded = exclude_end? ? color == last : false

      in_between?(color.r, first.r, last.r) &&
        in_between?(color.g, first.g, last.g) &&
        in_between?(color.b, first.b, last.b) &&
        !excluded
    end
    alias :member?  :===
    alias :include? :===

    def in_between?(value, one, other)
      (value <= one && value >= other) ||
        (value >= one && value <= other)
    end
    private :in_between?

    def inspect
      if exclude_end?
        "#{first.inspect}...#{last.inspect}"
      else
        "#{first.inspect}..#{last.inspect}"
      end
    end
    alias :to_s :inspect

    def hash
      excl = exclude_end? ? 1 : 0
      hash = excl
      hash ^= first.hash << 1
      hash ^= last.hash << 9
      hash ^= excl << 24;
      return hash
    end
  end
end
