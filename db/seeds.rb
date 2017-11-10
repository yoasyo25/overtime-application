admin =  User.create(email: 'admin@test.com', password: 'asdfasdf',
  password_confirmation: 'asdfasdf', first_name: "John",
  last_name: 'Snow', type: "AdminUser", phone: "1234567890")

@user =  User.create(email: 'user@test.com', password: 'asdfasdf',
                    password_confirmation: 'asdfasdf', first_name: "John",
                    last_name: 'Snow', phone: "2024685847")


100.times do |audit_log|
  AuditLog.create(user_id: @user.id, status: 0,
                 start_date: (Date.today - 6.days), end_date: nil)
end

puts "1 User created"
puts "1 Admin created"
puts "100 Audit logs created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post + 1}: Justo tortor maecenas
              eu non litora diam, pretium accumsan malesuada nunc dictum.
              Vehicula tellus ligula, donec vestibulum, vitae facilisis
              vulputate, sit mauris duis sodales orci. Quam neque, etiam quis,
              quam magna voluptate nunc justo, parturient eros magnis fusce
              venenatis, dolor nisl. Varius hymenaeos commodo erat, eu quis
              nam malesuada leo vitae. Eu taciti. Neque nunc faucibus vestibulum
              odio, laoreet amet, nam ultricies morbi aenean id nunc, vestibulum
              cubilia risus amet vel, vitae eget gravida curabitur nec tempus.
              Dapibus dignissim suscipit, et convallis.",
              user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"
