class Bag < ActiveRecord::Base
  belongs_to :locker
  scope :small, -> { where(size: 'small') }
  scope :medium, -> { where(size: 'medium') }
  scope :large, -> { where(size: 'large') }
  scope :checked, -> { where.not(locker_id: nil) }
  scope :unchecked, -> { where(locker_id: nil) }
end
