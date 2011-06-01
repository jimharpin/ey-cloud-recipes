require 'pp'
#
# Cookbook Name:: thinking_sphinx
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  # be sure to replace "app_name" with the name of your application.
  run_for_app("evatool") do |app_name, data|
  
    directory "/var/run/sphinx" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    directory "/var/log/engineyard/sphinx/#{app_name}" do
      recursive true
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    directory "/data/#{app_name}/shared/config/sphinx" do
      recursive true
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    remote_file "/etc/logrotate.d/sphinx" do
      owner "root"
      group "root"
      mode 0755
      source "sphinx.logrotate"
      backup false
      action :create
    end

    execute "monit reload" do
      action :nothing
    end

    template "/etc/monit.d/sphinx.#{app_name}.monitrc" do
      source "sphinx.monitrc.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name],
        :env => node[:environment][:framework_env],
      })
      notifies :run, resources("execute[monit reload]")
    end

    template "/data/#{app_name}/shared/config/sphinx.yml" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      source "sphinx.yml.erb"
      variables({
        :app_name => app_name,
        :user => node[:owner_name]
      })
    end
  end
end
