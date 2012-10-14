class Street
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :name_normalized, String
  attribute :city_ref
  attribute :zip_ref
  attribute :other_part_refs
  attribute :street

  attr_accessor :city_name
  attr_accessor :zip

  def Street.find_by_name(name)
    self.find_by_aql "FOR street IN streets FILTER street.name_normalized == '#{name}' RETURN street"
  end

  def Street.find(params)
    if params.has_key? :zip
      zip = Zip.find_by_name(params[:zip]).first
      lat = zip.center["lat"]
      lon = zip.center["lon"]
      radius = zip.radius
    elsif params.has_key? :city
      city = City.find_by_name(params[:city]).first
      lat = city.center["lat"]
      lon = city.center["lon"]
      radius = city.radius
    else
      return Street.find_by_name params[:street]
    end

    osm_ids = Ashikawa::AR::Setup.databases[:default].query "for street in streets filter street.name_normalized == '#{params[:street]}' return { osm_id: street.osm_id }"
    osm_ids = osm_ids.map { |raw| raw["osm_id"] }

    street_subquery = "[" + osm_ids.join(", ") + "]"

    query = "for street_point in within(street_points, #{lat}, #{lon}, #{radius}) " +
            "filter street_point.street_ref in #{street_subquery} " +
            "return street_point"

    street_points = StreetPoint.find_by_aql query

    street = Street.first_example osm_id: street_points.sample.street_ref

    street.city_name = city.name if city

    if zip
      street.zip = zip.name
      street.city_name = zip.city
    end

    [street]
  end

  def street_points
    StreetPoint.by_example street_ref: osm_id
  end

  def to_s
    "<#Street name='#{name}'>"
  end
end
