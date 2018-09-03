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

  def name
    if @brands.is_a?(Array)
      "#{@name} (produces #{@brands.join(', ')})"
    else
      "#{@name} (produces #{@brands})"
    end
    
  end
end

class UnsupportedBrandException < Exception
end

=begin
jezeli w supported brands nie ma danego pojedynczego stringa 
&& (i)
jak odejmiesz brands od supported i wynik wyjdzie 4 

TO -> wywal exceptioin
=end