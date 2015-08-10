class Category < ActiveRecord::Base  
  enum context: { recreation: 0, business: 1 }

  # associations
  has_many :categorizations
  has_many :meetings, through: :categorizations, source: :categorizable, source_type: 'Meeting'
  has_many :locations, through: :categorizations, source: :categorizable, source_type: 'Location'

end
