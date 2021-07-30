#
# Cookbook:: tomcat
# Recipe:: install_tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Create a user for tomcat
group 'tomcat'

directory '/opt/tomcat'

user 'tomcat' do
  gid 'tomcat'
  home '/opt/tomcat'
  shell '/bin/nologin'
  action :create
end

# tomcat_package = Chef::Config[:file_cache_path] + '/tomcat.tar.gz'
tomcat_package = '/tmp/tomcat.tar.gz'
# Download the Tomcat Binary
remote_file tomcat_package do
  source node['tomcat']['download_url']
  action :create
end

# Extract the Tomcat Binary
execute 'extract_tomcat' do
  command 'sudo tar xvf tomcat.tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

# Update the Permissions
execute 'update_permission' do
  cwd '/opt/tomcat'
  command 'sudo chgrp -R tomcat /opt/tomcat'
  command 'sudo chmod -R g+r conf'
  command 'sudo chmod g+x conf'
  command 'sudo chown -R tomcat webapps/ work/ temp/ logs/ bin/ lib/ conf/'
end

# Install the Systemd Unit File
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

# Reload Systemd to load the Tomcat Unit file
systemd_unit 'daemon-reload' do
  action :reload
end

# Ensure tomcat is started and enabled
service 'tomcat' do
  action [:enable, :start]
end
