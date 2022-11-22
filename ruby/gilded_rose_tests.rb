require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def test_generic_item_sellin_reduced
    items = [Item.new("generic item", 3, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 2
  end

  def test_generic_item_quality_reduced
    items = [Item.new("generic item", 3, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 2
  end

  def test_generic_item_quality_reduced_twice_as_fast_after_sellby_date_passed
    items = [Item.new("generic item", 0, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 1
  end

  def test_generic_item_quality_never_negative
    items = [Item.new("generic item", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 0
  end

  def test_aged_brie_sellin_reduces
    items = [Item.new(AGED_BRIE, 3, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 2
  end

  def test_aged_brie_quality_increases
    items = [Item.new(AGED_BRIE, 3, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 4
  end

  def test_aged_brie_quality_increases_twice_as_fast_after_sellby_date_passed
    items = [Item.new(AGED_BRIE, 0, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 5
  end

  def test_aged_brie_quality_never_exceeds_50
    items = [Item.new(AGED_BRIE, 3, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
  end

  def test_sulfuras_sellin_stays_the_same
    items = [Item.new(SULFURAS, 3, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 3
  end

  def test_sulfuras_quality_stays_the_same
    items = [Item.new(SULFURAS, 3, 80)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 80
  end

  def test_backstage_passes_quality_increases_when_sellin_above_10
    items = [Item.new(BACKSTAGE_PASSES, 11, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 4
  end

  def test_backstage_passes_quality_increases_2x_when_sellin_at_10
    items = [Item.new(BACKSTAGE_PASSES, 10, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 5
  end

  def test_backstage_passes_quality_increases_2x_when_sellin_at_6
    items = [Item.new(BACKSTAGE_PASSES, 6, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 5
  end

  def test_backstage_passes_quality_2x_increases_when_sellin_between_10_and_6
    items = [Item.new(BACKSTAGE_PASSES, 7, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 5
  end

  def test_backstage_passes_quality_increases_3x_when_sellin_below_6
    items = [Item.new(BACKSTAGE_PASSES, 5, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 6
  end

  def test_backstage_passes_quality_is_0_after_sellby_date_passed
    items = [Item.new(BACKSTAGE_PASSES, 0, 3)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 0
  end

  def test_backstage_passes_quality_never_exceeds_50
    items = [Item.new(BACKSTAGE_PASSES, 3, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
  end
end
