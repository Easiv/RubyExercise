class Car
  AVAILABLE_COLORS = []

  def initialize(brand, color: nil)
    @brand = brand
    @color = color || self.class.next_color
  end

  def brand
    humanize(@brand)
  end

  def color_name
    humanize(@color)
  end

  private
  def humanize(property)
    property.to_s.split('_').map(&:capitalize).join(' ')
  end

  def self.next_color
    AVAILABLE_COLORS.any? ? available_colors.next : nil 
  end

  def self.available_colors
    @@available_color ||= AVAILABLE_COLORS.cycle
  end
end