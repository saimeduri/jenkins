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
  gpg key 'https://jenkins-ci.org/redhat/jenkins-ci.org.key'
  action :create
end

yum_package 'jenkins' do
  action :install
end

group 'jenkins' do
  action :create
  gid '1234'
  append true
end

user 'myjenkins' do
  uid '1234'
  gid '1234'
  home '/home/jenkins'
  shell '/bin/bash'
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action [:enbale, :start]
end

