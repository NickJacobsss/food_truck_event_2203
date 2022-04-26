require 'pry'

class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    trucks_arr = []
    @food_trucks.each do |truck|
      truck.inventory.each do |k, v|
        trucks_arr << truck if k.name.include?(item.name)
      end
    end
    trucks_arr
  end

  def sorted_item_list
    items_arr = []
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        items_arr << item
    end
    end
    items_arr.uniq.sort_by do |item|
      item.name
    end
  end

  def overstocked_items
    total_inventory.map do |item, values|
    item if values[:quantity] > 50 and values[:food_trucks].length > 1
  end.compact
  end

  def total_inventory
    inventory_hash = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        inventory_hash[item] = {quantity: 0, food_trucks: []} if inventory_hash[item].nil?
        inventory_hash[item][:quantity] += quantity
        inventory_hash[item][:food_trucks] << truck
        end
      end
    inventory_hash
  end

end
