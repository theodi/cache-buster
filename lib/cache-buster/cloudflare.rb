module CacheBuster
 class Cloudflare

   def initialize
     @connection = Rubyflare.connect_with(ENV['CLOUDFLARE_EMAIL'], ENV['CLOUDFLARE_API_KEY'])
   end

   def clear(path = 'news')
     @connection.delete("/zones/#{zone[:id]}/purge_cache", {
       files: ["#{zone[:host]}/#{path}"]
     })
   end

   def zone
     @zone ||= begin
       zone = @connection.get("zones/#{ENV['CLOUDFLARE_ZONE_ID']}")
       {
         id: zone.results[:id],
         host: "http://#{zone.results[:name]}"
       }
     end
   end

 end
end
