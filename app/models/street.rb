class Street
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :name_normalized, String
  attribute :city_ref
  attribute :zip_ref
  attribute :other_part_refs
  attribute :points
  attribute :street

  def Street.find_by_name(name)
    self.find_by_aql "FOR street IN streets FILTER street.name_normalized == '#{name}' RETURN street"
  end

  def Street.find_by_name_and_city(name, city)
    city = City.find_first_by_name city
    [city.center, city.radius]
  end

  # def Street.find_by_name_and_number(name, number)
    # self.find_by_aql "FOR street IN streets FILTER street.name_normalized == '#{name}' && '#{number}' in street.street_numbers RETURN street"
  # end

  def to_s
    "<#Street name='#{name}'>"
  end
end
