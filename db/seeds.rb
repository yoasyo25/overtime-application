@user =  User.create(email: 'test1@test.com', password: 'asdfasdf',
  password_confirmation: 'asdfasdf', first_name: "John",
  last_name: 'Snow')

puts "1 User created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post + 1}: Posting",
               user_id: @user.id)
end

puts "100 posts have been created"
