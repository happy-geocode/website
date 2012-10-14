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

  attr_accessor :city

  def Street.find_by_name(name)
    self.find_by_aql "FOR street IN streets FILTER street.name_normalized == '#{name}' RETURN street"
  end

  # def Street.find_by_name_and_city(name, city)
    # city = City.find_first_by_name city
    # [city.center, city.radius]
  # end

  def Street.find(params)
    if params.has_key? :zip
      zip = Zip.find_by_name(params[:zip]).first
      lat = zip.center["lat"]
      lon = zip.center["lon"]
      radius = 2000 #city.radius
    elsif params.has_key? :city
      city = City.find_by_name(params[:city]).first
      lat = city.center["lat"]
      lon = city.center["lon"]
      radius = 2000 #city.radius
    end

    street_subquery = "(for street in streets filter street.name_normalized == '#{params[:street]}' return street.osm_id)"

    query = "FOR street_point IN within(street_points, #{lat}, #{lon}, #{radius}) " +
            "LET street_refs = #{street_subquery} " +
            "FILTER street_point.street_ref IN street_refs " +
            "RETURN street_point"

    street_points = StreetPoint.find_by_aql query

    street = Street.first_example osm_id: street_points.sample.street_ref

    street.city = city if city

    [street]
  end

  def to_s
    "<#Street name='#{name}'>"
  end
end
