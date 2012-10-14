class Zip
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :name_normalized, String
  attribute :center
  attribute :radius
  attribute :state_ref
  attribute :country_ref
  attribute :city

  def Zip.find_by_name(name)
    self.by_example name: name
  end
end
