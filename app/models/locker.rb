class Locker < ActiveRecord::Base
  has_one :bag
  scope :small, -> { where(size: 'small') }
  scope :medium, -> { where(size: 'medium') }
  scope :large, -> { where(size: 'large') }
  scope :empty, -> { where.not(id: Bag.pluck(:locker_id).uniq) }
  scope :full, -> { where(id: Bag.pluck(:locker_id).uniq) }
end
