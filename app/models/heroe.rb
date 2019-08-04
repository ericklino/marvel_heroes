class Heroe
   @private_key = nil
   @public_key = nil


   def initialize (private_key, public_key)
     @private_key =  private_key
     @public_key = public_key
   end


   def md5
     ts = Time.now.strftime("%Y-%m-%d %H:%M")
     md5 = Digest::MD5.hexdigest(ts + @private_key + @public_key)
     md5
   end

   def request_heroes(endpoint, params = nil)

     url = "http://gateway.marvel.com/v1/public/#{endpoint}"
     url << "?&ts=#{URI.encode(Time.now.strftime("%Y-%m-%d %H:%M"))}&apikey=#{@public_key}&hash=#{md5}"

     if params.present?
       params.each do |key, value|
         url << "&#{key}=#{value}&"
       end
       url = url[0..-2]
     end


     request = Typhoeus::Request.new(url)
     resp = request.run
     if resp.code == 200
       data = resp.body
       result = JSON.parse(data)
       result
     end
   end

end
