#
# Cookbook:: tomcat
# Spec:: install_java
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::install_java' do
  context 'When all attributes are default, on Centos 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs java successfully' do
      expect(chef_run).to install_package('java-1.8.0-openjdk')
    end
  end
end
