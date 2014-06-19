include_recipe 'firewall'

firewall_rule "ssh" do
  port 22
  action :allow
end

firewall_rule "http" do
  port 80
  action :allow
end

firewall_rule "strongloop" do
  port 3000
  action :allow
end

if node[:strongloop][:ssl_cert] and node[:strongloop][:ssl_key]
  firewall_rule "https" do
    port 443
    action :allow
  end
end
