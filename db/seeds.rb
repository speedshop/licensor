# First, CGRP
Content.create!(
  position: 0,
  title: "The Complete Guide to Rails Performance", 
  s3_key: "cgrp.tar.gz",
  style: "cgrp"
)

6.times do |section|
  Content.create!(
    position: section * 100 + 100,
    title: "Section #{section} Introduction", 
    s3_key: "text_#{section}.md",
    style: "text"
  )

  6.times do |video|
    Content.create!(
      position: (section * 100 + 100) + (video * 10 + 10),
      title: "Video: #{section}:#{video}", 
      s3_key: "video_#{section}_#{video}.mp4",
      style: "video"
    )

    Content.create!(
      position: (section * 100 + 100) + (video * 10 + 15),
      title: "Quiz: #{section}:#{video}", 
      s3_key: "quiz_#{section}_#{video}.md",
      style: "quiz"
    )
  end 

  Content.create!(
    position: section * 100 + 100 + 90,
    title: "Lab #{section}", 
    s3_key: "lab_#{section}.tar.gz",
    style: "lab"
  ) 
end
