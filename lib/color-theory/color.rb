module ColorTheory
  class Color
    attr_reader :r, :g, :b

    def self.from_hex(code)
      Color.new(*code.scan(/../).map{ |v| v.hex })
    end

    def initialize(r, g, b)
      {"@r" => r, "@g" => g, "@b" => b}.each_pair do |name, value|
        if value < 0
          instance_variable_set(name, 0)
        elsif value > 255
          instance_variable_set(name, 255)
        else
          instance_variable_set(name, value)
        end
      end
    end

    def hex
      [r, g, b].inject("") do |s, c|
        if c < 16
          s + "0" + c.to_s(16)
        else
          s + c.to_s(16)
        end
      end
    end

    def ==(other)
      other.is_a?(Color) &&
        r == other.r &&
        g == other.g &&
        b == other.b
    end

    def shade(percent = 0.2)
      amount = (255 * percent).to_i
      Color.new(r - amount,
                g - amount,
                b - amount)
    end

    def tint(percent = 0.2)
      amount = (255 * percent).to_i
      Color.new(r + amount,
                g + amount,
                b + amount)
    end

    def inspect
      "rgb(#{r}, #{g}, #{b})"
    end
    alias :to_s :inspect

    def hash
      hash =  r.hash << 1
      hash ^= g.hash << 9
      hash ^= b.hash << 24;
      return hash
    end

    def +(other)
      Color.new( (r + other.r) / 2,
                 (g + other.g) / 2,
                 (b + other.b) / 2)
    end
  end
end
