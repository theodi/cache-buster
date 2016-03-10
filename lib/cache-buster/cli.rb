module CacheBuster
 class Cli < Thor
   desc "clear PATH", "clears the cache at PATH"
   option :hard, :type => :boolean
   def clear(path = 'news')
     if options[:hard]
       say "********************************************************************************************************\n", :red
       say "*                                 SUPER MEGA IMPORTANT WARNING                                         *\n", :red
       say "********************************************************************************************************\n", :red
       say "* This will reboot all three backend nodes cleanly to completely clear the mysterious invisible caches *\n", :red
       say "* Before doing this, you should try and clear a page cache without the --hard option                   *\n", :red
       say "********************************************************************************************************\n\n", :red
       if yes?('Are you sure you want to proceed?', :yellow)
         say "\nPreparing to clear the cache with brute force. Press ctrl + c to cancel\n", :red
         (1..5).to_a.reverse_each { |i| say "#{i}.. ", :red ; sleep 1 }
         say "\n\nClearing cache.... ", :red
         Rackspace.new.clear
         say "Done!\n", :green
       else
         say "\nAborting. This was probably the right decision.\n", :green
       end
     else
       say "Clearing cache for #{path}..... ", :yellow
       Cloudflare.new.clear(path)
       say "Done!", :green
     end
   end

   desc "watch", "watches for a button press"
   method_option :daemon,
              type: :boolean,
              default: false,
              desc: 'Creates a file `.pid` with the current process ID'
   def watch
     if options['daemon']
       file = File.new(File.join('/', 'tmp', 'cache-buster.pid'), 'w+')
       file.write(Process.pid)
       file.rewind
       file.close
     end
     say "Waiting for someone to press a button"
     Pi.new
   end

 end
end
