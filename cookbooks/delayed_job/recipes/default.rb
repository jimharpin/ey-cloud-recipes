#
# Cookbook Name:: delayed_job
# Recipe:: default
#
 
if node[:instance_role] == "solo" || (node[:instance_role] == "util" && node[:name] !~ /^(mongodb|redis|memcache)/)
  node[:applications].each do |app_name,data|

    execute "monit reload" do
      action :nothing
    end

    template "/etc/monit.d/delayed_job.#{app_name}.monitrc" do
      source "dj.monitrc.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name],
        :worker_name => "delayed_job",
        :framework_env => node[:environment][:framework_env]
      })
      notifies :run, resources("execute[monit reload]")
    end
  end
end
