=begin
require "active_record"

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('test')

class User < ActiveRecord::Base
end
=end
require "time"

def ping(ip)
  r = Regexp.new('[1-9]\d* (packets )?received')
  puts ip
  result = r.match(`ping -c 1 -W 1 #{ip}`)
  result != nil
end
 
def arp(ip)
  r = Regexp.new('[0-f]+:[0-f]+:[0-f]+:[0-f]+:[0-f]+:[0-f]+')
  result = r.match(`arp -n #{ip}`)
  result ? result.to_s : nil
end
 
def get_mac_addresses
  file = File.open('/var/lib/dhcp/dhcpd.leases').read
  data = {:time => Time.now-(24*60*60),:ip=>nil}
  
  
  a = file.scan(/(\d+\.\d+\.\d+\.\d+)\s\{(.+?)\}/m)
  a.each{|lease|
    if lease[1].match(/0c:3e:9f:26:ee:8b/) 
            time = Time.parse(lease[1].scan(/starts\s\d\s(\d+\/\d+\/\d+\s\d+:\d+:\d+)/).flatten[0])
            if data[:time] < time
                    data[:time] = time
                    data[:ip] = lease[0]
            end
    end
  }
  data
end
 
p get_mac_addresses
