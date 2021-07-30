#
# Cookbook:: tomcat
# Recipe:: install_java
#
# Copyright:: 2021, The Authors, All Rights Reserved.
# Install OpenJDK 7 JDK

package node['java']['package'] do
  action :install
end
