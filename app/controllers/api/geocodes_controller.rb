module Api
  class GeocodesController < ApplicationController
    respond_to :json, :xml

    def show
      data_stub = { lat: 50.123123, lon: 6.21123 }

      respond_with data_stub
    end
  end
end
