FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Rationale"
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Content"
    user
  end
end
