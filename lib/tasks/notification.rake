namespace :notification do
  desc "Sends SMS notification to employess asking them to log overtime requests"
  task sms: :environment do
    if Time.now.saturday?

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
