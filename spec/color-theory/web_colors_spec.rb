require 'spec_helper'

module ColorTheory
  describe WebColors do
    describe "#web_safe?" do
      it "returns true if the color is in the web safe list" do
        color = WebColors::web_safe_colors[0]
        color.should be_web_safe
      end

      it "returns false if the color is not in the web safe list" do
        color = Color.new(5, 154, 0)
        color.should_not be_web_safe
      end
    end
  end
end
