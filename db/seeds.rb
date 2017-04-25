# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[Employee, Position, Department].each(&:delete_all)

@sales = Department.create!(name: 'Sales')
@management = Department.create!(name: 'Management')
@engineering = Department.create!(name: 'Engineering')

def random_dept
  [@sales, @management, @engineering].sample
end

def create_position(index)
  Position.create! title: Faker::Job.title,
    department: random_dept,
    historical_index: index
end

def create_employee
  Employee.create! \
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(20..80),
    positions: [create_position(1), create_position(2)]
end

100.times do
  create_employee
end
