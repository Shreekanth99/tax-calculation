Employee.delete_all

10.times do |i|
  random_code = SecureRandom.hex(3).upcase
  Employee.create!(
    employee_code: "EMP#{random_code}",
    first_name: "Employee#{i+1}",
    last_name: "Lastname#{i+1}",
    email: "employee#{i+1}@example.com",
    phone_number: ["1234567890", "0987654321"],
    doj: Date.today - rand(1..365).days,
    salary: rand(50000..150000).to_d
  )
end
