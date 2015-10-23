set :output, 'cron.log'

every 1.day, at: '7:00 pm' do
  runner "NotificationJob.new.send_texts"
end

every 1.day do
  # runner "NotificationJob.new.send_example_text"
end
