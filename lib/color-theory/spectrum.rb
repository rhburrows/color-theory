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

    def step(percent = 0.2)
      r_range = get_range(first.r, last.r)
      g_range = get_range(first.g, last.g)
      b_range = get_range(first.b, last.b)

      r_step = (r_range.last - r_range.first) * percent
      g_step = (g_range.last - g_range.first) * percent
      b_step = (b_range.last - b_range.first) * percent

      current_color = first
      while (current_color.r <= r_range.last &&
             current_color.g <= g_range.last &&
             current_color.b <= b_range.last &&
             current_color != last)
        yield current_color

        new_r = next_value(r_range, r_step, current_color.r).to_i
        new_g = next_value(g_range, g_step, current_color.g).to_i
        new_b = next_value(b_range, b_step, current_color.b).to_i

        current_color = Color.new(new_r, new_g, new_b)
      end

      yield last unless exclude_end?
    end

    def each(&blk)
      step(0.2, &blk)
    end

    def get_range(one, other)
      if one < other
        Range.new(one, other, exclude_end?)
      else
        Range.new(other, one, exclude_end?)
      end
    end
    private :get_range

    def next_value(range, step, current)
      nxt = current + step
      if nxt > range.last
        range.last
      else
        nxt
      end
    end
    private :next_value

    def eql?(other)
      other.is_a?(Spectrum) &&
        first.eql?(other.first) &&
        last.eql?(other.last) &&
        (exclude_end? == other.exclude_end?)
    end
  end
end
