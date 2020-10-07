(1..36).each do |i| 
  Content.create!(title: "Lesson #{i}", position: i)
end