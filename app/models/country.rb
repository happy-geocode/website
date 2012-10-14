class Country
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :name_normalized, String
  attribute :center
  attribute :radius
end
