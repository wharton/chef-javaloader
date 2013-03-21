#
# Cookbook Name:: javaloader
# Recipe:: javaloader
#
# Copyright 2013, Nathan Mische
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install the unzip package

package "unzip" do
  action :install
end

node.set['javaloader']['owner'] = "nobody" if node['javaloader']['owner'] == nil

file_name = node['javaloader']['download']['url'].split('/').last

# Download javaloader

remote_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
  source "#{node['javaloader']['download']['url']}"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.directory?("#{node['javaloader']['install_path']}/javaloader") }
end

# Create Directory if missing

directory "#{node['javaloader']['install_path']}" do
 owner node['javaloader']['owner']
 group node['javaloader']['group']
 mode "0755"
 recursive true
 action :create
 not_if { File.directory?("#{node['javaloader']['install_path']}") }
end

# Extract archive

script "install_javaloader" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
  code <<-EOH
unzip #{file_name} -d #{node['javaloader']['install_path']}/javaloader 
chown -R #{node['javaloader']['owner']}:#{node['javaloader']['group']} #{node['javaloader']['install_path']}/javaloader
EOH
  not_if { File.directory?("#{node['javaloader']['install_path']}/javaloader") }
end

# Set up ColdFusion mapping

execute "start_cf_for_javaloader_default_cf_config" do
  command "/bin/true"
  notifies :start, "service[coldfusion]", :immediately
end

coldfusion902_config "extensions" do
  action :set
  property "mapping"
  args ({ "mapName" => "/javaloader",
          "mapPath" => "#{node['javaloader']['install_path']}/javaloader"})
end

