require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

# check if there are emails to send each hour
scheduler.every '1d' do
  puts 'emailing'
  @reminders = Reminder.all
  @reminders.each do |reminder|
    if reminder.should_mail
      # commenting out in development for now
      #ReminderMailer.reminder_email(reminder).deliver
    end
  end
end