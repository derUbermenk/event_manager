require 'csv'
require 'time'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

registration_hours = []

contents.each do |row|
  time_of_registry = row[:regdate].split(' ')[1]
  registration_hours << time_of_registry.split(':')[0]
end

reg_count = registration_hours.group_by{|i| i}.transform_values(&:length)
puts reg_count.keys.select {|key| reg_count[key] == reg_count.values.max}.join(" ")