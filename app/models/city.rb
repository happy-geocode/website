class City
  include Ashikawa::AR::Model

  attribute :name, String
  attribute :country_ref
  attribute :state_ref
  attribute :center
  attribute :radius
end
