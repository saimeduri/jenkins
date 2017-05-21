#
# Cookbook:: myjenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'yum_update' do
  command 'yum -y update'
end

yum_package 'java-1.8.0-openjdk-devel.x86_64' do
  action :install
end

yum_package 'wget' do
  action :install
end

execute 'wget_repo' do
  command 'wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo'
end

execute 'rpm_import' do
  command 'rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key'
end

execute 'install_jenkins' do
  command 'yum -y install jenkins'
end

yum_package 'jenkins' do
  action :install
end

template '/etc/profile' do
  source 'profile.erb'
  mode '0755'
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
