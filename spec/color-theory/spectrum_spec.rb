require 'spec_helper'

module ColorTheory
  describe Spectrum do
    let(:red){ Color.new(255, 0, 0) }
    let(:green){ Color.new(0, 255, 0) }
    let(:blue){ Color.new(0, 0, 255) }
    let(:black){ Color.new(0, 0, 0) }
    let(:white){ Color.new(255, 255, 255) }

    describe "#==" do
      it "returns true if the ranges are the same" do
        s1 = Spectrum.new(red, blue)
        s2 = Spectrum.new(red, blue)
        s1.should == s2
      end

      it "returns false if they have different begins" do
        s1 = Spectrum.new(red, blue)
        s2 = Spectrum.new(green, blue)
        s1.should_not == s2
      end

      it "returns false if they have different ends" do
        s1 = Spectrum.new(red, blue)
        s2 = Spectrum.new(red, green)
        s1.should_not == s2
      end

      it "returns false if they have different exclude_end?s" do
        s1 = Spectrum.new(red, blue, true)
        s2 = Spectrum.new(red, blue, false)
        s1.should_not == s2
      end
    end

    describe "#===" do
      it "returns true if the color lies between the start and end colors" do
        s = Spectrum.new(black, white)
        (s === red).should be_true
      end

      it "returns false if the color's red value is outside the range" do
        s = Spectrum.new(Color.new(100, 0, 0), Color.new(200, 0, 0))
        (s === red).should be_false
      end

      it "returns false if the color's green value is outside the range" do
        s = Spectrum.new(Color.new(0, 100, 0), Color.new(0, 100, 0))
        (s === green).should be_false
      end

      it "returns false if the color's blue value is outside the range" do
        s = Spectrum.new(Color.new(0, 0, 100), Color.new(0, 0, 200))
        (s === blue).should be_false
      end

      it "returns false if the range is exclusive and it equals the end" do
        s = Spectrum.new(red, green, true)
        (s === green).should be_false
      end

      it "returns true if the range is inclusive and it equals the end" do
        s = Spectrum.new(red, green, false)
        (s === green).should be_true
      end
    end

    describe "#member?" do
      it "returns true if the color lies between the start and end colors" do
        s = Spectrum.new(black, white)
        s.member?(red).should be_true
      end

      it "returns false if the color's red value is outside the range" do
        s = Spectrum.new(Color.new(100, 0, 0), Color.new(200, 0, 0))
        s.member?(red).should be_false
      end

      it "returns false if the color's green value is outside the range" do
        s = Spectrum.new(Color.new(0, 100, 0), Color.new(0, 100, 0))
        s.member?(green).should be_false
      end

      it "returns false if the color's blue value is outside the range" do
        s = Spectrum.new(Color.new(0, 0, 100), Color.new(0, 0, 200))
        s.member?(blue).should be_false
      end

      it "returns false if the range is exclusive and it equals the end" do
        s = Spectrum.new(red, green, true)
        s.member?(green).should be_false
      end

      it "returns true if the range is inclusive and it equals the end" do
        s = Spectrum.new(red, green, false)
        s.member?(green).should be_true
      end
    end

    describe "#include?" do
      it "returns true if the color lies between the start and end colors" do
        s = Spectrum.new(black, white)
        s.include?(red).should be_true
      end

      it "returns false if the color's red value is outside the range" do
        s = Spectrum.new(Color.new(100, 0, 0), Color.new(200, 0, 0))
        s.include?(red).should be_false
      end

      it "returns false if the color's green value is outside the range" do
        s = Spectrum.new(Color.new(0, 100, 0), Color.new(0, 100, 0))
        s.include?(green).should be_false
      end

      it "returns false if the color's blue value is outside the range" do
        s = Spectrum.new(Color.new(0, 0, 100), Color.new(0, 0, 200))
        s.include?(blue).should be_false
      end

      it "returns false if the range is exclusive and it equals the end" do
        s = Spectrum.new(red, green, true)
        s.include?(green).should be_false
      end

      it "returns true if the range is inclusive and it equals the end" do
        s = Spectrum.new(red, green, false)
        s.include?(green).should be_true
      end
    end

    describe "#begin" do
      it "returns the first color of the spectrum" do
        Spectrum.new(red, blue).begin.should == red
      end
    end

    describe "#first" do
      it "returns the first color of the spectrum" do
        Spectrum.new(red, blue).first.should == red
      end
    end

    describe "#each" do
      it "takes 5 (equal) steps through the spectrum" do
        colors = []
        Spectrum.new(black, red, true).each do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(51, 0, 0),
                           Color.new(102, 0, 0),
                           Color.new(153, 0, 0),
                           Color.new(204, 0, 0) ]
      end

      it "includes the last step if not exclude_end" do
        colors = []
        Spectrum.new(black, red, false).each do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(51, 0, 0),
                           Color.new(102, 0, 0),
                           Color.new(153, 0, 0),
                           Color.new(204, 0, 0),
                           Color.new(255, 0, 0) ]
      end
    end

    describe "#end" do
      it "returns the last color of the spectrum" do
        Spectrum.new(red, blue).end.should == blue
      end
    end

    describe "#last" do
      it "returns the last color of the spectrum" do
        Spectrum.new(red, blue).last.should == blue
      end
    end

    describe "#eql?" do
      it "returns true if the two ends are #eql? and the exclude_end" do
        s1 = Spectrum.new(black, white)
        s2 = Spectrum.new(black, white)
        s1.eql?(s2).should be_true
      end

      it "returns false if the first aren't #eql" do
        s1 = Spectrum.new(black, white)
        s2 = Spectrum.new(red, white)
        s1.eql?(s2).should be_false
      end

      it "returns false if the last aren't #eql" do
        s1 = Spectrum.new(black, white)
        s2 = Spectrum.new(black, red)
        s1.eql?(s2).should be_false
      end

      it "returns false if the exclude_end aren't the same" do
        s1 = Spectrum.new(black, white, true)
        s2 = Spectrum.new(black, white, false)
        s1.eql?(s2).should be_false
      end
    end

    describe "#exclude_end?" do
      it "returns true if the spectrum excludes its end value" do
        Spectrum.new(red, blue, true).exclude_end?.should be_true
      end

      it "returns false if the spectrum includes its end value" do
        Spectrum.new(red, blue, false).exclude_end?.should be_false
      end
    end

    describe "#hash" do
      it "returns the same hash for two matching spectrums" do
        r1, g1, b1 = rand(256), rand(256), rand(256)
        r2, g2, b2 = rand(256), rand(256), rand(256)
        Spectrum.new(Color.new(r1, g1, b1), Color.new(r2, g2, b2)).hash.
          should ==
          Spectrum.new(Color.new(r1, g1, b1), Color.new(r2, g2, b2)).hash
      end

      it "returns different hashes if the begins are different" do
        r, g, b = rand(256), rand(256), rand(256)
        Spectrum.new(red, Color.new(r, g, b)).hash.should_not ==
          Spectrum.new(green, Color.new(r, g, b)).hash
      end

      it "returns different hashes if the ends are different" do
        r, g, b = rand(256), rand(256), rand(256)
        Spectrum.new(Color.new(r, g, b), red).hash.should_not ==
          Spectrum.new(Color.new(r, g, b), blue).hash
      end

      it "returns different hashes if the exclude_end is differend" do
        Spectrum.new(red, blue, false).hash.should_not ==
          Spectrum.new(red, blue, true).hash
      end
    end

    describe "#inspect" do
      it "joins the two inspected end points by '..' if not exclude_end" do
        Spectrum.new(red, blue, false).inspect.should ==
          "rgb(255, 0, 0)..rgb(0, 0, 255)"
      end

      it "joins the two inspected end points by '...' if exclude_end" do
        Spectrum.new(red, blue, true).inspect.should ==
          "rgb(255, 0, 0)...rgb(0, 0, 255)"
      end
    end

    describe "#to_s" do
      it "joins the two inspected end points by '..' if not exclude_end" do
        Spectrum.new(red, blue, false).to_s.should ==
          "rgb(255, 0, 0)..rgb(0, 0, 255)"
      end

      it "joins the two inspected end points by '...' if exclude_end" do
        Spectrum.new(red, blue, true).to_s.should ==
          "rgb(255, 0, 0)...rgb(0, 0, 255)"
      end
    end

    describe "#step" do
      it "takes 5 (equal) steps through the spectrum" do
        colors = []
        Spectrum.new(black, red, true).step do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(51, 0, 0),
                           Color.new(102, 0, 0),
                           Color.new(153, 0, 0),
                           Color.new(204, 0, 0) ]
      end

      it "includes the last step if not exclude_end" do
        colors = []
        Spectrum.new(black, red, false).step do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(51, 0, 0),
                           Color.new(102, 0, 0),
                           Color.new(153, 0, 0),
                           Color.new(204, 0, 0),
                           red ]
      end

      it "makes steps of the specified percent size" do
        colors = []
        Spectrum.new(black, white, true).step(0.5) do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(127, 127, 127),
                           Color.new(254, 254, 254) ]
      end

      it "makes steps of the specified size and includes the last" do
        colors = []
        Spectrum.new(black, white, false).step(0.5) do |color|
          colors << color
        end
        colors.should == [ black,
                           Color.new(127, 127, 127),
                           Color.new(254, 254, 254),
                           white ]
      end
    end
  end
end
