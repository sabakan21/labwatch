=begin
require "active_record"

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('test')

class User < ActiveRecord::Base
end
=end

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
  mac_adresses = Array.new
  network_address = '192.168.63.'
 
  arp_table = `arp -n`
  arp_table.each_line{|arp|
    if arp.match(/0c:3e:9f:26:ee:8b/) {
            ip = arp.match(/[0-9]+¥.[0-9]+¥.[0-9]+¥.[0-9]/)
            puts ip
  }
  mac_adresses
end
 
p get_mac_addresses
