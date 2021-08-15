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

tomcat_package = "/tmp/tomcat-#{node['tomcat']['version']}.tar.gz"
tomcat_home_dir = '/opt/tomcat'

# Download the Tomcat Binary
remote_file tomcat_package do
  source node['tomcat']['download_url']
  action :create
end

# Extract the Tomcat Binary
execute 'extract_tomcat' do
  command "sudo tar xvf #{tomcat_package} -C #{tomcat_home_dir} --strip-components=1"
  cwd '/tmp'
  action :run
  not_if "java -cp #{tomcat_home_dir}/lib/catalina.jar org.apache.catalina.util.ServerInfo | /usr/bin/grep #{node['tomcat']['version']}"
end

# Update the Permissions
execute 'update_permission' do
  cwd tomcat_home_dir
  command "sudo chgrp -R tomcat #{tomcat_home_dir}"
  command 'sudo chmod -R g+r conf'
  command 'sudo chmod g+x conf'
  command 'sudo chown -R tomcat LICENSE webapps/ work/ temp/ logs/ bin/ lib/ conf/'
  not_if { Etc.getpwuid(::File.stat("#{tomcat_home_dir}/LICENSE").uid).name == 'tomcat' }
end

# Install the Systemd Unit File
template 'Systemd Unit File' do
  path '/etc/systemd/system/tomcat.service'
  source 'tomcat.service.erb'
  notifies :reload, 'systemd_unit[daemon-reload]', :immediately
end

# Reload Systemd to load the Tomcat Unit file
systemd_unit 'daemon-reload' do
  action :nothing
end

# Ensure tomcat is started and enabled
service 'tomcat' do
  action [:enable, :restart]
end
