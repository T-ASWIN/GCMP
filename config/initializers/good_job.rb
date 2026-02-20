# config/initializers/good_job.rb
Rails.application.configure do
  # This keeps a history of your jobs in the database.
  # Set to false if you want them deleted immediately after finishing.
  config.good_job.preserve_job_records = true

  # If a job crashes, this is where you'd send the error to a service like Sentry.
  # config.good_job.on_thread_error = -> (exception) { Rails.error.report(exception) }

  # How many "lanes" of work can one process do?
  config.good_job.max_threads = 5

  # Example of a Cron (Scheduled Task)
  # This runs a job called 'CleanupJob' every day at midnight
  # config.good_job.cron = {
  #   daily_cleanup: { cron: '0 0 * * *', class: 'CleanupJob' }
  # }
end
