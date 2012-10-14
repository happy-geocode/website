# encoding: utf-8
class Geocoder

  # Finds the geolocation for a given adress.
  #
  # Possible Parameters:
  # - query = the acutal query string, e.g. "Bergstr. 1, 50739 Köln"
  #
  # ToDo:
  # - country = if you want to help us detect the country for the adress
  # - lat, long = if you want to help us detect the most relevant adress
  def find(params)
    return [] if params[:query].blank?
    parsed = Parsec.parse params[:query]

    enrich_parsed parsed
  end

  private

  def enrich_parsed(parsed)
    # Try to find by street
    found_entries = find_streets(parsed)

    Rails.logger.debug parsed.inspect

    # Continue searching if we didn't find anything
    if found_entries.empty?
      found_entries.concat find_zip_matches(parsed.zip) if parsed.zip
      found_entries.concat find_city_matches(parsed.city) if parsed.city
    end

    found_entries
  end

  def find_streets(parsed)
    unless parsed.street_name
      return []
    end

    search_options = {}
    search_options[:street] = parsed.street_name
    search_options[:zip] = parsed.zip if parsed.zip
    search_options[:city] = parsed.city if parsed.city && !parsed.zip

    street_matches = Street.find(search_options)

    street_matches.map do |s|
      spoint = s.street_points.first
      {
        street: s.name,
        city: s.city_name,
        zip: s.zip,
        lat: spoint.lat,
        lon: spoint.lon,
        accurarcy: 'street',
        accuracy_face: ':)'
      }
    end
  end

  def find_zip_matches(zip)
    zip_matches = Zip.find_by_name(zip)

    Rails.logger.debug zip

    zip_matches.map do |m|
      {
        street: nil,
        city: m.city,
        zip: m.name,
        lat: m.center["lat"],
        lon: m.center["lon"],
        accurarcy: 'zip',
        accuracy_face: ':/'
      }
    end
  end

  def find_city_matches(city)
    city_matches = City.find_by_name(city)

    city_matches.map do |m|
      {
        street: nil,
        city: m.name,
        zip: nil,
        lat: m.center["lat"],
        lon: m.center["lon"],
        accurarcy: 'city',
        accuracy_face: ':O'
      }
    end
  end

end
