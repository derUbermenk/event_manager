require 'csv'
require 'date'

def clean_date(date)
  date = date.split[0]

  date.split('/').map{ |unit| unit.length < 2 ? "0#{unit}" : unit }.join('/')
end

def day_of_registry(date)
  Date::DAYNAMES[Date.strptime(date, '%m/%d/%Y').wday]
end

def highest_reg_by_day(reg_days)
  reg_count = reg_days.group_by{|i| i}.transform_values(&:length)
  reg_count.keys.select {|key| reg_count[key] == reg_count.values.max}.join(" ")
end
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

days_of_reg = []

contents.each do |row|
  days_of_reg << day_of_registry(clean_date(row[:regdate]))
end

puts highest_reg_by_day(days_of_reg)
