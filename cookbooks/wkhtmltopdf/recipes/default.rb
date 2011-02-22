#
# Cookbook Name:: wkhtmltopdf
# Recipe:: default
#
execute "manual wkhtmltopdf install" do
command "wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-static-i386.tar.bz2 -O /tmp/wkhtmltopdf.tar.bz2 && " +
"tar jxf /tmp/wkhtmltopdf.tar.bz2 && sudo mv /tmp/wkhtmltopdf-i386 /usr/local/bin/wkhtmltopdf"
not_if { File.exists?("/usr/local/bin/wkhtmltopdf") }
end