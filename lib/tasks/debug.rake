desc 'Tell passenger to restart the application with debugging enabled.'

task :debug do
  require 'byebug/core'

  # Indicate debugging mode
  FileUtils.touch(File.join(Rails.root, 'tmp', 'debug.txt'))

  # Tell passenger to restart the application
  FileUtils.touch(File.join(Rails.root, 'tmp', 'restart.txt'))

  # Wait for restart of application
  puts '(waiting) Please ping any url of your application...'
  begin
    while File.exists?(File.join(Rails.root, 'tmp', 'debug.txt'))
      sleep 0.5
    end
  rescue Interrupt
    File.delete(File.join(Rails.root, 'tmp', 'debug.txt'))

    puts 'Cancelled by user; exiting...'
    exit 1
  end

  puts 'Starting Byebug client...'

  begin
    Byebug.start_client('localhost', 8989)
  rescue Interrupt
    puts 'Cancelled by user; exiting...'
    exit 1
  end

end
