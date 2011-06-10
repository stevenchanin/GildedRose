require './item.rb'

class Normal < Item
  def update
    self.sell_in -= 1
    self.quality -= (self.sell_in >= 0 ? 1 : 2)

    self.quality = 0 if self.quality < 0
  end
end

class Cheese < Item
  def update
    self.sell_in -= 1
    self.quality += (self.sell_in >= 0 ? 1 : 2)

    self.quality = 50 if self.quality > 50
  end
end

class Legendary < Item
  def update
  end
end

class Pass < Item
  def update
    self.sell_in -= 1

    if sell_in < 0
      self.quality = 0
    elsif sell_in < 5
      self.quality += 3
    elsif sell_in < 10
      self.quality += 2
    else
      self.quality += 1
    end

    self.quality = 0 if self.quality < 0
    self.quality = 50 if self.quality > 50
  end
end

class Conjoured < Item
  def update
    self.sell_in -= 1

    self.quality -= (self.sell_in >= 0 ? 2 : 4)
    self.quality = 0 if self.quality < 0
  end
end

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Normal.new("+5 Dexterity Vest", 10, 20)
    @items << Cheese.new("Aged Brie", 2, 0)
    @items << Normal.new("Elixir of the Mongoose", 5, 7)
    @items << Legendary.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Pass.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Conjoured.new("Conjured Mana Cake", 3, 6)
    @items << Conjoured.new("Conjured Biscuit", 10, 40)
  end

  def find_item(name)
    @items.detect {|i| i.name =~ Regexp.new("#{name}","i")}
  end

  def update_quality
    @items.each {|i| i.update}
  end
end
