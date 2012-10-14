class City
  include Ashikawa::AR::Model

  attribute :osm_id
  attribute :name, String
  attribute :country_ref
  attribute :state_ref
  attribute :center
  attribute :radius

  def City.find_first_by_name(name)
    self.by_example(name_normalized: name).first
  end

  def to_s
    "<#City name='#{name}'>"
  end
end
