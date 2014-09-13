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
  network_address = '172.20.0'
 
  2.upto(254) do |n|
    ip = '%s.%d' % [network_address, n]
    if ping(ip)
      mac_adresses << arp(ip)
    end
  end
 
  mac_adresses
end
 
p get_mac_addresses
