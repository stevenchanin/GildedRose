require './gilded_rose.rb'
require "rspec"

describe "GildedRose" do
  before(:each) do
    @rose = GildedRose.new
  end

  describe "find item" do
    it "should have a Vest" do
      @vest = @rose.find_item("Vest")

      @vest.name.should eql("+5 Dexterity Vest")
      @vest.sell_in.should eql(10)
      @vest.quality.should eql(20)
    end

    it "should have a vest" do
      @vest = @rose.find_item("vest")

      @vest.name.should eql("+5 Dexterity Vest")
      @vest.sell_in.should eql(10)
      @vest.quality.should eql(20)
    end

    it "should not have a vestx" do
      @vest = @rose.find_item("vestx")

      @vest.should be_nil
    end
  end

  describe "vest" do
    before(:each) do
      @vest = @rose.find_item("Vest")
    end

    it "should start with sell_in 10 and quality 20" do
      @vest.sell_in.should eql(10)
      @vest.quality.should eql(20)
    end

    it "should lose 1 quality point per day for the first 10" do
      quality = 20
      day = 10

      10.times do
        quality -= 1
        day -= 1

        @rose.update_quality
        @vest.sell_in.should eql(day)
        @vest.quality.should eql(quality)
      end
    end

    it "should lose 2 quality points for the next 5 days" do
      10.times { @rose.update_quality }

      quality = @vest.quality

      5.times do
        quality -= 2

        @rose.update_quality
        @vest.quality.should eql(quality)
      end
    end

    it "should min out at 0 quality" do
      15.times { @rose.update_quality }
      @vest.quality.should eql(0)

      @rose.update_quality
      @vest.quality.should eql(0)
    end
  end #vest

  describe "Aged Brie" do
    before(:each) do
      @brie = @rose.find_item("Brie")
    end

    it "should start at sell_in 2 and quality 0" do
      @brie.sell_in.should eql(2)
      @brie.quality.should eql(0)
    end

    it "should increase by 1 quality until it hits the sell_in = 0" do
      sell_in = 2
      quality = 0

      while (@brie.sell_in > 0) do
        sell_in -= 1
        quality += 1

        @rose.update_quality
        @brie.sell_in.should eql(sell_in)
        @brie.quality.should eql(quality)
      end
    end

    it "should increase by 2 for the next 23 days" do
      2.times { @rose.update_quality }
      @brie.quality.should eql(2)


      quality = 2
      23.times do
        quality += 2

        @rose.update_quality
        @brie.quality.should eql(quality)
      end
    end #next 23

    it "should cap out at 50 quality" do
      26.times { @rose.update_quality }
      @brie.quality.should eql(50)

      @rose.update_quality
      @brie.quality.should eql(50)
    end
  end #brie

  describe "Sulfuras" do
    before(:each) do
      @sulfuras = @rose.find_item("Sulfuras")
    end

    it "should not have a sell_in" do
      @sulfuras.sell_in.should eql(0)
    end

    it "should not have sell_in decrease" do
      @rose.update_quality
      @sulfuras.sell_in.should eql(0)
    end

    it "should have quality fixed at 80" do
      @sulfuras.quality.should eql(80)

      @rose.update_quality
      @sulfuras.quality.should eql(80)
    end
  end #Sulfuras

  describe "Backstage" do
    before(:each) do
      @backstage = @rose.find_item("Backstage")
    end

    it "should start with sell_in 15 and quality 20" do
      @backstage.sell_in.should eql(15)
      @backstage.quality.should eql(20)
    end

    it "should increase by 1 for 5 days" do
      quality = 20

      5.times do
        quality += 1

        @rose.update_quality
        @backstage.quality.should eql(quality)
      end
    end

    it "should increase by 2 between days 10 and 6" do
      5.times { @rose.update_quality }
      @backstage.quality.should eql(25)

      quality = 25
      (10..6).each do |i|
        quality += 2

        @rose.update_quality
        @backstage.quality.should eql(quality)
      end
    end

    it "should increase by 3 between days 5 and 0" do
      10.times { @rose.update_quality }
      @backstage.quality.should eql(35)

      quality = 35
      (5..1).each do |i|
        quality += 3

        @rose.update_quality
        @backstage.quality.should eql(quality)
      end
    end

    it "should drop to 0 after sell_in date hits 0" do
      15.times { @rose.update_quality }
      @backstage.quality.should eql(50)
      @backstage.sell_in.should eql(0)

        @rose.update_quality
        @backstage.quality.should eql(0)
    end

  end #backstage
end
