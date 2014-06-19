include_recipe 'nginx'

begin
  databag = Chef::EncryptedDataBagItem.load(node[:strongloop][:databag_name], "secrets")
  node.set[:strongloop][:ssl_cert] = databag['strongloop']['ssl_cert'] rescue node[:strongloop][:ssl_cert]
  node.set[:strongloop][:ssl_key] = databag['strongloop']['ssl_key'] rescue node[:strongloop][:ssl_key]
  node.set[:strongloop][:ssl_cacert] = databag['strongloop']['ssl_cacert'] rescue node[:strongloop][:ssl_cacert]
rescue
  nil
end

if node[:strongloop][:ssl_cert] and node[:strongloop][:ssl_key]
  file ::File.join(node[:strongloop][:ssl_cert_path], node[:strongloop][:domain] + ".crt") do
    content node[:strongloop][:ssl_cert]
    action :create
    owner "root"
    group "root"
    mode 00644
  end
  file ::File.join(node[:strongloop][:ssl_key_path], node[:strongloop][:domain] + ".key") do
    content node[:strongloop][:ssl_key]
    action :create
    owner "root"
    group "root"
    mode 00600
  end
  if node[:strongloop][:ssl_cacert]
    file ::File.join(node[:strongloop][:ssl_cacert_path], node[:strongloop][:domain] + ".ca.crt") do
      content node[:strongloop][:ssl_cacert]
      action :create
      owner "root"
      group "root"
      mode 00644
    end
  end
end

template "/etc/nginx/sites-available/strongloop" do
  source "nginx-site.erb"
  notifies :restart, "service[nginx]"
end

nginx_site "strongloop" do
  enable true
end
