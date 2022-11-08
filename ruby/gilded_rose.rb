class GildedRose
  attr_accessor :items
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        if item.sell_in < 1
          item.quality += 2
        else
          item.quality += 1
        end
        item.sell_in -= 1
      when "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in
        item.quality = item.quality
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in >10
          item.quality += 1
        elsif item.sell_in > 5 && item.sell_in <= 10
          item.quality += 2
        elsif item.sell_in < 6 && item.sell_in > 0
          item.quality += 3
        elsif item.sell_in < 1
          item.quality = 0
        end
      else
        if item.sell_in < 1
          item.quality -= 2
        else
          item.quality -= 1
        end
        item.sell_in -= 1
      end
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

  def expiry_rate(item_name)

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
