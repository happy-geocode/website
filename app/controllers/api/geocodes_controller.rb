module Api
  class GeocodesController < ApplicationController
    respond_to :json, :xml

    def show

      fake_data = {
        center: {
          lat: 50.939771,
          lng: 6.887213
        },
        locations: [
          {
            street_name: 'An der Alten Post',
            street_number: '12',
            zip: '50859',
            city: 'Koeln',
            state: 'NRW',
            country: 'Germany',
            lat: 50.937229,
            lng: 6.832788,
            accuracy: 'exact'
          },
          {
            street_name: 'Bruesseler Strasse',
            street_number: '55',
            zip: '50672',
            city: 'Koeln',
            state: 'NRW',
            country: 'Germany',
            lat: 50.937993,
            lng: 6.934578,
            accuracy: 'exact'
          },
        ]
      }
      # exact, street_level, city, wild_guess

      respond_with fake_data
    end
  end
end
