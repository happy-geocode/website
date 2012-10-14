class Street
  include Ashikawa::AR::Model

  attribute :name, String
  attribute :name_normalized, String
  attribute :city_ref
  attribute :zip_ref
  attribute :other_part_refs
  attribute :points
  attribute :street
end
