(1..36).each do |i|
  Content.create!(title: "Lesson #{i}", position: i, s3_key: "#{i}_file.mov")
end
