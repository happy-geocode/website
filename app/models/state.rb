class State
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :name_normalized, String
  attribute :country_ref
  attribute :center
  attribute :radius
end
