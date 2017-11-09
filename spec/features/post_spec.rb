require 'rails_helper'

describe 'navigate' do
  before do
    @user =  FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    visit new_post_path
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      @post1 = FactoryGirl.build_stubbed(:post)
      @post2 = FactoryGirl.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|Content/)
    end

    it 'has a scope so that only post creators can see their posts' do
      post1 = Post.create(date: Date.today, rationale: "Something",
                          user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: "Or Another",
                          user_id: @user.id)
      other_user = User.create(first_name: "Non", last_name: "Authorized",
                            email: "email@email.com", password: 'asdfasdf',
                            password_confirmation: 'asdfasdf')
      post_from_other_user = Post.create(date: Date.today, rationale:
                                        'This content should not be seen',
                                        user_id: other_user.id)
      visit posts_path

      expect(page).to_not have_content('This content should not be seen')
    end
  end

  describe "creation" do
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end

    it "can be created from new form page" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "some rationale"

      click_on "Save"

      expect(page).to have_content("some rationale")
    end

    it "will have a user associated with it" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"

      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User Association")
    end
  end

  describe "new" do
    it "has a link on the homepage" do
      visit root_path
      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe "delete" do
    it "can be deleted" do
      post = FactoryGirl.create(:post, user_id: @user.id)
      visit posts_path

      click_link("delete_post_#{post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post, user_id: @user.id)
    end

    it "can be edited" do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"

      expect(page).to have_content("Edited content")
    end

    it "cannot be edited by a non authorized user" do
      logout(:user)
      non_authorized_user = create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
    end
  end
end
