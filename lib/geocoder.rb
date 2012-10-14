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
    # ToDo: Add actual searching in arango :)
    [{
      street_name: parsed.street_name,
      street_number: parsed.street_number,
      zip: parsed.zip,
      city: parsed.city,
      state: parsed.state,
      country: "Germany",
      lat: 50.937229,
      lng: 6.832788,
      accuracy: 'exact'
    }]
  end
end
