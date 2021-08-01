#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
include_recipe 'tomcat::install_java'
include_recipe 'tomcat::install_tomcat'
