require 'csv'
def clean_phone_number(phone_number) 
  phone_number = phone_number.gsub(/[^0-9]/, '')

  case phone_number.length
  when 10
    phone_number
  when 11
    phone_number[0] == 1 ? phone_number[1..10] : nil.to_s.rjust(10, '0')
  else
    nil.to_s.rjust(10, '0')
  end
end

# @param first_name [String]
# @param last_name [String]
def clean_name(first_name, last_name)
  "#{first_name.capitalize} #{last_name.capitalize}"
end

def save_to_file(name, phone_number, filename, directory)
  dir = "#{directory}/#{filename}"
  data = "#{name}: #{phone_number} \n"
  File.write(dir, data, mode: 'a')
end

def setup_directory(directory)
  Dir.mkdir(directory) unless Dir.exist?(directory)
end
#test
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

directory = "output/phone_data"
filename = "phone_data.txt"

setup_directory(directory)

contents.each do |row|
  name = clean_name(row[:first_name], row[:last_name])
  phone_number = clean_phone_number(row[:homephone])

  save_to_file(name, phone_number, filename, directory)
end
