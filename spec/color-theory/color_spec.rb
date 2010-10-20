require 'spec_helper'

module ColorTheory
  describe Color do
    describe "::from_hex" do
      it "parses the correct r,g,b values" do
        ["ff0010", "ffffff", "000000", "00ff00", "13a45f"].each do |code|
          Color.from_hex(code).hex.should == code
        end
      end
    end

    describe "#initialize" do
      it "converts r values lower than 0 to 0" do
        Color.new(-10, 0, 0).should == Color.new(0, 0, 0)
      end

      it "converts g values lower than 0 to 0" do
        Color.new(0, -10, 0).should == Color.new(0, 0, 0)
      end

      it "converts b values lower than 0 to 0" do
        Color.new(0, 0, -10).should == Color.new(0, 0, 0)
      end

      it "converts r values higher than 255 to 255" do
        Color.new(300, 0, 0).should == Color.new(255, 0, 0)
      end

      it "converts g values higher than 255 to 255" do
        Color.new(0, 300, 0).should == Color.new(0, 255, 0)
      end

      it "converts b values higher than 255 to 255" do
        Color.new(0, 0, 300).should == Color.new(0, 0, 255)
      end
    end

    describe "#hex" do
      it "converts to hexadecimal notation as a string" do
        c = Color.new(255, 0, 16)
        c.hex.should == "ff0010"
      end
    end

    describe "#==" do
      it "is equal if the r,g,b values are equal" do
        c1 = Color.new(15, 53, 255)
        c2 = Color.new(15, 53, 255)
        c1.should == c2
      end

      it "isn't equal if the r values are not equal" do
        c1 = Color.new(14, 53, 255)
        c2 = Color.new(15, 53, 255)
        c1.should_not == c2
      end

      it "isn't equal if the g values are not equal" do
        c1 = Color.new(15, 52, 255)
        c2 = Color.new(15, 53, 255)
        c1.should_not == c2
      end

      it "isn't equal if the b values are not equal" do
        c1 = Color.new(15, 53, 254)
        c2 = Color.new(15, 53, 255)
        c1.should_not == c2
      end
    end

    describe "#shade" do
      it "lowers the red intesity 20%" do
        c = Color.new(255, 0, 0)
        c.shade.should == Color.new(204, 0, 0)
      end

      it "lowers the green intesity 20%" do
        c = Color.new(0, 255, 0)
        c.shade.should == Color.new(0, 204, 0)
      end

      it "lowers the blue intesity 20%" do
        c = Color.new(0, 0, 255)
        c.shade.should == Color.new(0, 0, 204)
      end
    end

    describe "#tint" do
      it "raises the red intesity 20%" do
        c = Color.new(204, 255, 255)
        c.tint.should == Color.new(255, 255, 255)
      end

      it "raises the green intesity 20%" do
        c = Color.new(255, 204, 255)
        c.tint.should == Color.new(255, 255, 255)
      end

      it "raises the blue intesity 20%" do
        c = Color.new(255, 255, 204)
        c.tint.should == Color.new(255, 255, 255)
      end
    end
  end
end