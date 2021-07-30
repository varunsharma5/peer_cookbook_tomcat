#
# Cookbook:: tomcat
# Spec:: install_tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::install_tomcat' do
  # context 'When all attributes are default, on Ubuntu 20.04' do
  #   # for a complete list of available platforms and versions see:
  #   # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
  #   platform 'ubuntu', '20.04'

  #   it 'converges successfully' do
  #     expect { chef_run }.to_not raise_error
  #   end
  # end

  context 'When all attributes are default, on CentOS 8' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    # it 'installs tomcat successfully' do
    #   expect(chef_run).to install_package('tomcat')
    # end

    it 'starts tomcat service successfully' do
      expect(chef_run). to start_service('tomcat')
      expect(chef_run). to enable_service('tomcat')
    end
  end
end
