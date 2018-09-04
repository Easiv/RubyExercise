require 'pry'
require 'car_factory/car'

class CarFactory
  SUPPORTED_BRANDS = ["Fiat", "Lancia", "Ford", "Subaru"]

  def initialize(name, brands=nil)
    @name = name
    @brands = brands.values.pop

    if @brands.is_a?(Array)
      @brands = brands.values.pop.map(&:to_s).map(&:capitalize!)

      if (SUPPORTED_BRANDS - @brands).length == 4
        raise UnsupportedBrandException.new("Factory does not have a brand or do not support it")
      end

    else
      @brands = brands.values.pop.to_s.capitalize

      unless SUPPORTED_BRANDS.include?(@brands)       
        raise UnsupportedBrandException.new("Brand not supported: '#{@brands}'")
      end
    end
  end

  def name
    if @brands.is_a?(Array)
      "#{@name} (produces #{@brands.join(', ')})"
    else
      "#{@name} (produces #{@brands})"
    end
  end

  def make_car(car=nil)
    if !car && !@brands.is_a?(Array)
      car = @brands
      Car.new(car)
    elsif @brands.include?(car.to_s.capitalize!) 
      Car.new(car)
    else
      raise UnsupportedBrandException.new("Factory does not have a brand or do not support it")
    end
  end

  def make_cars(brands=@brands, amount)

    cars = []

    if amount.is_a?(Hash)
      hashBrands = amount.keys.map(&:to_s).map(&:capitalize)
      diff = hashBrands - SUPPORTED_BRANDS

      if diff != []
        diff = diff.pop.to_sym.downcase
      end
      
      amount.each { |k, v|  v.times { if k != diff then car = Car.new(k); cars.push(car) end } }
    end

    if brands.is_a?(Array) && !amount.is_a?(Hash)
      $i = 0
      currentBrands = brands.cycle(10).to_a
      while $i < amount
        car = Car.new(currentBrands[$i])
        cars.push(car)
        $i += 1
      end

    else
      $i = 0
      unless amount.is_a?(Hash)
        while $i < amount
          car = Car.new(brands)
          cars.push(car)
          $i += 1
        end
      end
    end
    cars
  end
end

class UnsupportedBrandException < Exception
end
