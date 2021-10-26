LicenseKey.create!(key: "this-is-a-key")

Content.create!(
  position: 0,
  title: "Welcome to the Workshop",
  s3_key: "video_0_0.mp4",
  style: "video"
)

Content.create!(
  position: 5,
  title: "The Complete Guide to Rails Performance",
  s3_key: "cgrp.tar.gz",
  style: "cgrp"
)

# Section Intros
["Performance Measurement", "Full-Stack Performance", "Ruby Benchmarking",
  "ActiveRecord", "Profiling", "Scaling"].each_with_index do |section, i|
  Content.create!(
    position: i * 100 + 100,
    title: "Section: #{section}",
    s3_key: "intro_#{i}.md",
    style: "text"
  )
end

[
  "Understanding Requirements",
  "Production Profilers",
  "Assessing Rails Apps",
  "Live Assessment Example"
].each_with_index do |video, index|
  Content.create!(
    position: 100 + ((index + 1) * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_0_#{index + 1}.mp4",
    style: "video",
    indent: 1
  )

  next if [0].include? index

  Content.create!(
    position: 100 + ((index + 1) * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_0_#{index + 1}.yaml",
    style: "quiz",
    indent: 2
  )
end

[
  "How Front-End Perf Works",
  "Optimizing LCP",
  "Optimizing CRC",
  "Optimizing Interactions",
  "Using webpagetest.org"
].each_with_index do |video, index|
  Content.create!(
    position: 200 + (index * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_1_#{index}.mp4",
    style: "video",
    indent: 1
  )

  next if [3,4].include? index

  Content.create!(
    position: 200 + (index * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_1_#{index}.yaml",
    style: "quiz",
    indent: 2
  )
end

[
  "Benchmarking and Profiling",
  "Creating a Local Perf Environment",
  "Using Apache Bench",
  "Using benchmark-ips",
  "Benchmarking Background Jobs",
  "Benchmarking Rails' Boot"
].each_with_index do |video, index|
  Content.create!(
    position: 300 + (index * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_2_#{index}.mp4",
    style: "video",
    indent: 1
  )

  next if [1,5].include? index

  Content.create!(
    position: 300 + (index * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_2_#{index}.yaml",
    style: "quiz",
    indent: 2
  )
end

[
  "The DRM Method",
  "Profiling SQL",
  "Fixing N+1s",
  "Diagnose Unnecessary SQL",
  "Secret Rails AR Caches",
  "Fix Slow SQL with EXPLAIN"
].each_with_index do |video, index|
  Content.create!(
    position: 400 + (index * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_3_#{index}.mp4",
    style: "video",
    indent: 1
  )

  next if [1].include? index

  Content.create!(
    position: 400 + (index * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_3_#{index}.yaml",
    style: "quiz",
    indent: 2
  )
end

[
  "How Profiling Works",
  "Using Stackprof",
  "Profiling Background Jobs",
  "Profiling Boot",
  "Profiling Memory",
  "Profiling Test Suites",
  "Perf Review Processes"
].each_with_index do |video, index|
  Content.create!(
    position: 500 + (index * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_4_#{index}.mp4",
    style: "video",
    indent: 1
  )

  next if [6].include? index

  Content.create!(
    position: 500 + (index * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_4_#{index}.yaml",
    style: "quiz",
    indent: 2
  )
end

[
  "On Queueing Theory",
  "The USE Method, Part One",
  "The USE Method, Part Two",
  "Database Pools",
  "The GVL and Threads"
].each_with_index do |video, index|
  Content.create!(
    position: 600 + (index * 10 + 10),
    title: "Video: #{video}",
    s3_key: "video_5_#{index}.mp4",
    style: "video",
    indent: 1
  )

  Content.create!(
    position: 600 + (index * 10 + 12),
    title: "Quiz",
    s3_key: "quiz_5_#{index}.yaml",
    style: "quiz",
    indent: 2
  )
end

{
  0 => [[4, "Lab: Application Assessment"]],
  1 => [[0,"Lab: Critical Request Chain"],[3,"Lab: Turbolinks"]],
  2 => [[2,"Lab: HTTP Benchmarking"],[3,"Lab: benchmark-ips"]],
  3 => [[0,"Handout: Activerecord Troubleshooting"],[2,"Lab: Fixing N+1s"],[3,"Lab: Unnecessary SQL"]],
  4 => [[6,"Handout: Perf PR/Transaction Checklists"]],
  5 => [[4, "Lab: Scaling in Miniature"]]
}.each do |section, data|
  data.each do |d|
    index = d[0]
    title = d[1]
    Content.create!(
      position: section * 100 + 100 + (index * 10 + 14),
      title: title,
      s3_key: "lab_#{section}_#{index}.tar.gz",
      style: "lab",
      indent: 2
    )
  end
end

{
  0 => [[2, "PR: Prod Perf Monitoring"]],
  1 => [[2,"PR: Frontend Mistakes"]],
  2 => [[1,"PR: Local Perf Environment"]],
  3 => [[2,"PR: N+1s"],[3,"PR: Unnecessary SQL"],[4,"PR: QueryCache"]],
  4 => [[4,"PR: Memory Allocation"],[5,"PR: Tests"],[6,"PR: Capstone Project"],],
}.each do |section, data|
  data.each do |d|
    index = d[0]
    title = d[1]
    Content.create!(
      position: section * 100 + 100 + (index * 10 + 16),
      title: title,
      s3_key: "safari_#{section}_#{index}.md",
      style: "text",
      indent: 2
    )
  end
end

Content.create!(
  position: 0,
  title: "Introduction",
  s3_key: "intro.md",
  style: "text",
  product: 1
)

Content.create!(
  position: 5,
  title: "Sidekiq in Practice",
  s3_key: "sip.tar.gz",
  style: "sip",
  product: 1
)

# Section Intros
["How Sidekiq Works, and Why", "Understanding Queueing Systems", "Setting Concurrency",
  "Why Is My Queue So Long?", "How Many Queues Should I Have?", "Maximizing Servers",
  "My Jobs are Running Twice!", "Database Pools", "Is My App Thread-Safe?", "Using Less Memory"].each_with_index do |section, i|
  Content.create!(
    position: i * 100 + 100,
    title: section,
    s3_key: "chapter_#{i}.md",
    style: "text",
    product: 1
  )
end

[
  "Reducing Redis Load",
  "Multi-Server Setups",
  "Amdahl's Law",
  "Jobs Are Cheaper",
  "Load Shedding",
  "Scaling Redis... with SQL",
  "Managing SQL Load",
  "Multi-threading inside a Job",
  "Memory Profiling"
].each_with_index do |video, index|
  i = index + 1
  Content.create!(
    position: i * 100 + 100 + 10,
    title: "Video: #{video}",
    s3_key: "video_#{i}.mp4",
    style: "video",
    indent: 1,
    product: 1
  )

  Content.create!(
    position: i * 100 + 100 + 12,
    title: "Quiz",
    s3_key: "quiz_#{i}.yaml",
    style: "quiz",
    product: 1
  )

  Content.create!(
    position: i * 100 + 100 + 20,
    title: "Hands-on Lab",
    s3_key: "lab_#{i}.tar.gz",
    style: "lab",
    indent: 1,
    product: 1
  )
end