#
# Cookbook Name:: red5
# Recipe:: default
#

execute "init-red5" do
  command "/data/red5/red5.sh >& /dev/null &" #remember change red5.sh to set RED5_HOME
  action :run
  user 'deploy'
  not_if "pgrep -f red5"  
end
