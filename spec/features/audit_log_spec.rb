require 'rails_helper'

describe "AuditLog Feature" do
  before do
    @user = create(:user)
    @admin_user =  create(:admin_user)
    audit_log = create(:audit_log, user_id: @user.id)
    login_as(@admin_user, :scope => :user)
    visit audit_logs_path
  end

  describe "index" do
    it "has an index page that can be reached" do
      expect(current_path).to eq("/audit_logs")
      expect(page.status_code).to eq(200)
    end

    it "renders audit log content" do
      expect(page).to have_content(@user.full_name)
    end

    it "cannot be accessed by a non admin user" do
      logout(:user)
      user = create(:user)
      login_as(user, :scope => :user)

      visit audit_logs_path

      expect(current_path).to eq(root_path)
    end
  end
end
