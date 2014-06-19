# Load attributes from Encrypted DataBag if any
begin
  databag = Chef::EncryptedDataBagItem.load(node["strongloop"]["databag_name"], "secrets")
rescue
  Chef::Log.debug("No databag found. Using attributes.")
end

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
begin
  plain_pass = databag['strongloop']['password']
rescue
  if node['strongloop']['password'].nil?
    plain_pass = secure_password
  else
    plain_pass = node['strongloop']['password']
  end
end

# Create hash from password
if node['strongloop']['shadow_hash'].nil?
  salt = rand(36**8).to_s(36)
  shadow_hash = plain_pass.crypt("$6$" + salt)
  node.set_unless['strongloop']['shadow_hash'] = shadow_hash
end

chef_gem "ruby-shadow"

home_dir = ::File.join("/home", node['strongloop']['username'])

user node[:strongloop][:username] do
  supports :manage_home => true
  comment "StrongLoop User"
  shell "/bin/bash"
  home home_dir
  password node['strongloop']['shadow_hash']
  action :create
end

### Setup NodeJS and NPM
node.set['nodejs']['version'] = '0.10.26'
node.set['nodejs']['checksum'] = 'ef5e4ea6f2689ed7f781355012b942a2347e0299da0804a58de8e6281c4b1daa'
node.set['nodejs']['checksum_linux_x64'] = '305bf2983c65edea6dd2c9f3669b956251af03523d31cf0a0471504fd5920aac'
node.set['nodejs']['checksum_linux_x86'] = '8fa2d952556c8b5aa37c077e2735c972c522510facaa4df76d4244be88f4dc0f'

include_recipe "nodejs::install_from_binary"

bash "install_strong_cli" do
  code "npm install -g strong-cli"
end

if node['strongloop']['project_name']
  project_path = File.join(home_dir, node['strongloop']['project_name'])
else # Install the example app
  project_path = File.join(home_dir, 'sls-sample-app')
end

bash "strongloop_webapp" do
  environment "HOME" => home_dir
  cwd home_dir
  user node[:strongloop][:username]
  group node[:strongloop][:username]
  if node['strongloop']['project_name']
    code "slc lb project #{node['strongloop']['project_name']}"
  else # Install the example app
    code "slc example"
  end
  not_if {File.exists?(project_path)}
end

# Install any additional dependencies
node['strongloop']['npm_pkgs'].each do |pkg|
  bash "Installing npm requirement: #{pkg}" do
    environment "HOME" => home_dir
    cwd project_path
    user node[:strongloop][:username]
    group node[:strongloop][:username]
    code "npm install #{pkg} --save"
  end
end

include_recipe "supervisor"

supervisor_service "strongloop" do
  action :enable
  autostart true
  autorestart true
  user node['strongloop']['username']
  command "slc run #{File.basename(project_path)}"
  stopsignal "INT"
  stopasgroup true
  killasgroup true
  stopwaitsecs 20
  directory "#{home_dir}"
end
