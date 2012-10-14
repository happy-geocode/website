# encoding: utf-8
require 'geocoder'
module Api
  class GeocodesController < ApplicationController
    respond_to :json, :xml

    def show
      respond_with Geocoder.new.find(params)
    end

  end
end
