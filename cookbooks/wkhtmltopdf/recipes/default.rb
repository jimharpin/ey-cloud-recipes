#
# Cookbook Name:: wkhtmltopdf
# Recipe:: default
#

package "app-misc/wkhtmltopdf-bin" do
  version "0.10.0_beta5"
  action :install
end

#execute "manual wkhtmltopdf install" do
#  command "wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-static-i386.tar.bz2 -O /tmp/wkhtmltopdf.tar.bz2 && " +
#    "tar jxf /tmp/wkhtmltopdf.tar.bz2 && sudo mv /tmp/wkhtmltopdf-i386 /usr/local/bin/wkhtmltopdf"
#  not_if { File.exists?("/usr/local/bin/wkhtmltopdf") }
#end

# Clean up version installed by old mechanism
file "/usr/local/bin/wkhtmltopdf" do
  action :delete
end
