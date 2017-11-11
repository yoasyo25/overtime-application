namespace :notification do
  desc "Sends SMS notification to employess asking them to log overtime requests"
  task sms: :environment do
    if Time.now.saturday?
      employees            = Employee.all
      notification_message = "Please log into the overtime management dashboard to request overtime or confirm your hours for the previous week: http://yga-overtime-app.herokuapp.com/"

      employees.each do |employee|
        SmsTool.send_sms(number: employee.phone, message: notification_message)
      end
    end
  end

  desc "Sends email notification to managers/admin users each "
  task manager_email: :environment do
    submitted_posts = Post.submitted
    admin_users     = AdminUser.all

    if submitted_posts.count > 0
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_later
      end
    end
  end
end
