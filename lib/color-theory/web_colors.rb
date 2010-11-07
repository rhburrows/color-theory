module ColorTheory
  module WebColors
    class << self
      def web_safe_colors
        return @web_safe_colors if @web_safe_colors

        colors = [0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF]
        result = []
        colors.each do |c1|
          colors.each do |c2|
            colors.each do |c3|
              result << Color.new(c1, c2, c3)
            end
          end
        end
        @web_safe_colors = result.uniq
      end
    end

    def web_safe?
      WebColors.web_safe_colors.include?(self)
    end
  end
end
