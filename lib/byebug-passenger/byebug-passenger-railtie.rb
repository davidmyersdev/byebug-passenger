module ByebugPassenger
  class ByebugPassengerRailtie < Rails::Railtie
    initializer 'byebug-passenger' do
      if Rails.env.development? && File.exists?(File.join(Rails.root, 'tmp', 'debug.txt'))
        # pull in byebug core
        require 'byebug/core'

        # clean up our debug indicator file
        File.delete(File.join(Rails.root, 'tmp', 'debug.txt'))

        # start the byebug server
        Byebug.wait_connection = true
        Byebug.start_server('localhost', 8989)
      end
    end

    rake_tasks do
      load "tasks/debug.rake"
    end
  end
end
