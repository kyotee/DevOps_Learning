# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

package 'nginx' do
  action :install
end

cookbook_file "nginx-default" do
  path "/etc/nginx/sites-available/default"
end

execute 'restart_nginx' do
  command 'nginx -s quit'
  command 'nginx -s reload'
end

# Rails
package "ruby-dev"
package "sqlite3"
package "libsqlite3-dev"
package "zlib1g-dev"
package "nodejs"

execute 'bundler update' do
  command 'sudo gem install bundler'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end

execute 'bundler precondition 1' do
  command 'sudo apt-get install -y libxslt-dev'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end

execute 'bundler precondition 2' do
  command 'sudo apt-get install -y libpq-dev'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end

execute 'bundler' do
  command 'bundle install'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end

execute 'migrate' do
  command 'rake db:migrate'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end

execute 'hostserver' do
  command 'rails server -d -b 0.0.0.0'
  cwd '/home/vagrant/project/'
  user 'vagrant'
end
