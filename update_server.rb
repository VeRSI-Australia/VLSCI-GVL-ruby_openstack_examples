# Modify a server name
require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

server_id = '2620'

url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/servers/' + server_id)


class ServerUpdate
  def self.to_json(server_name, admin_password)
    JSON.generate (
    {
      'server' => 
      {
        'name' => server_name
      }
    })
  end
end



Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Put.new url.path
    
      # set the content type
      request.content_type = 'application/json'
      request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME)
      request['Accept'] = 'application/json'
    
      # set the body of the request
      request.body = ServerUpdate.to_json "Yet Another New Server Name", "password"
      #print request.body + "\n"
      
      raw_response = http.request request
      #json_response = JSON.parse raw_response.body
   
      print raw_response.body

    end
