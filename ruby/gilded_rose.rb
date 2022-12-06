class GildedRose
  attr_accessor :items

  def initialize(items)
    @adjusters = items.map { |item| ItemAdjuster.for(item) }
  end

  def update_quality
    @adjusters.each do |adjuster|
      adjuster.adjust
    end
  end
end

class ItemAdjuster
  attr_reader :item

  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  CONJURED = "Conjured"

  class << self
    def for(item)
      case item.name
      when AGED_BRIE
        BrieItemAdjuster
      when SULFURAS
        SulfurasItemAdjuster
      when BACKSTAGE_PASSES
        BackstagePassesItemAdjuster
      when CONJURED
        ConjuredItemAdjuster
      else
        ItemAdjuster
      end.new(item)
    end
  end

  def initialize(item)
    @item = item
  end

  def adjust
    item.quality += adjust_quality
    item.sell_in -= adjust_expiration
    item.quality = quality_range
  end

  def adjust_quality
    if item.sell_in < 1
      -2
    else
      -1
    end
  end

  def adjust_expiration
    1
  end

  def quality_range(max: 50, min: 0)
    if item.quality > max
      return max
    elsif item.quality < min
      return min
    else
      item.quality
    end
  end
end

class BrieItemAdjuster < ItemAdjuster
  def adjust_quality
    if item.sell_in < 1
      2
    else
      1
    end
  end
end

class SulfurasItemAdjuster < ItemAdjuster
  def adjust_quality
    0
  end

  def adjust_expiration
    0
  end

  def quality_range(max: 50, min: 0)
    80
  end
end

class BackstagePassesItemAdjuster < ItemAdjuster
  def adjust_quality
    if item.sell_in > 10
      1
    elsif item.sell_in > 5 && item.sell_in <= 10
      2
    elsif item.sell_in < 6 && item.sell_in > 0
      3
    elsif item.sell_in < 1
      -1 * item.quality
    end
  end
end

class ConjuredItemAdjuster < ItemAdjuster
  def adjust_quality
    super * 2
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
