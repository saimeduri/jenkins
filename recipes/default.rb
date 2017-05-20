#
# Cookbook:: myjenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'yum_update' do
  command 'yum -y update'
end

yum_package 'wget' do
  action :install
end

remote_file '/etc/yum.repos.d/jenkins.repo' do
  source 'http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo'
end

yum_repository 'jenkins' do
  description 'Install jenkins'
  baseurl "https://pkg.jenkins.io/redhat-stable"
  gpgkey 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key'
  action :create
end

yum_package 'jenkins' do
  action :install
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

