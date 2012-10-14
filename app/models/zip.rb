class Zip
  include Ashikawa::AR::Model

  attribute :name, String
  attribute :name_normalized, String
  attribute :center
  attribute :radius
  attribute :state_ref
  attribute :country_ref
end
