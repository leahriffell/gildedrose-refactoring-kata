class GildedRose
  attr_accessor :items

  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.quality += quality_adjustment(item)
      item.sell_in -= expiry_rate(item)
      item.quality = quality_range(item.quality)
    end
  end

  def quality_range(quality, max: 50, min: 0)
    if quality > max
      return max
    elsif quality < min
      return min
    else
      quality
    end
  end

  def expiry_rate(item)
    if item.name == SULFURAS
      return 0
    else
      return 1
    end
  end

  def quality_adjustment(item)
    ItemAdjuster.new(item).run
  end
end

class ItemAdjuster
  attr_reader :item

  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def initialize(item)
    @item = item
  end

  def run
    case item.name
    when AGED_BRIE
      if item.sell_in < 1
        2
      else
        1
      end
    when SULFURAS
      0
    when BACKSTAGE_PASSES
      if item.sell_in >10
        1
      elsif item.sell_in > 5 && item.sell_in <= 10
        2
      elsif item.sell_in < 6 && item.sell_in > 0
        3
      elsif item.sell_in < 1
        -1 * item.quality
      end
    else
      if item.sell_in < 1
        -2
      else
        -1
      end
    end
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
