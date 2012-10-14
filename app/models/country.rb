class Country
  include Ashikawa::AR::Model

  attribute :name, String
  attribute :name_normalized, String
  attribute :center
  attribute :radius
end
