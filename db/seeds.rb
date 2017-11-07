100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post + 1}: Posting")
end

puts "100 posts have been created"
