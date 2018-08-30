require 'pry'
class CarFactory
  SUPPORTED_BRANDS = ["Fiat", "Lancia", "Ford", "Subaru"]

  def initialize(name, brands=nil)
    @name = name
    @brands = brands.values.pop.to_s.capitalize

    raise UnsupportedBrandException.new("Brand not supported: '#{@brands}'") unless SUPPORTED_BRANDS.include?(@brands)

  end

end
class UnsupportedBrandException < Exception
end