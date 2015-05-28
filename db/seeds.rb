# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

1000.times do
  Locker.create!([{ size: 'small' }])
end

1000.times do
  Locker.create!([{ size: 'medium' }])
end

1000.times do
  Locker.create!([{ size: 'large' }])
end

5000.times do
  Bag.create!([
    { size: %w(small medium large).sample }])
end

i = 1
while i < 11
  Bag.small.unchecked.first.update_attributes(locker_id: i)
  i += 1
end

i = 1001
while i < 1011
  Bag.medium.unchecked.first.update_attributes(locker_id: i)
  i += 1
end

i = 2001
while i < 2011
  Bag.large.unchecked.first.update_attributes(locker_id: i)
  i += 1
end
