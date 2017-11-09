@user =  User.create(email: 'user@test.com', password: 'asdfasdf',
                    password_confirmation: 'asdfasdf', first_name: "John",
                    last_name: 'Snow', phone: "2024685847")

admin =  User.create(email: 'admin@test.com', password: 'asdfasdf',
                    password_confirmation: 'asdfasdf', first_name: "John",
                    last_name: 'Snow', type: "AdminUser", phone: "123456789")

puts "1 User created"
puts "1 Admin created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post + 1}: Posting",
               user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"
