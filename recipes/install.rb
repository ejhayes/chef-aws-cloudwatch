#
# Cookbook Name:: aws-cloudwatch
# Recipe:: install
#

if node['aws_cloudwatch']['region'].nil?
  if node['ec2'] && node['ec2']['region']
    node.normal['aws_cloudwatch']['region'] = node['ec2']['region']
  else
    log('AWS Region is necessary for this cookbook.') { level :error }
    return
  end
end

# download setup script that will install aws cloudwatch logs agent
remote_file "/tmp/AmazonCloudWatchAgent.zip" do
   source node['aws_cloudwatch']['source_zip']
   owner 'root'
   group 'root'
   mode 0755
   only_if { ! File.exists? "#{node['aws_cloudwatch']['path']}/bin/amazon-cloudwatch-agent-ctl" }
end

package 'unzip'
package 'python'
package 'epel-release' if node[:platform_family] == 'rhel'
package 'python-pip' if node[:platform_family] == 'rhel'

# unzip package
execute 'Unzip CloudWatch Agent' do
  command "unzip /tmp/AmazonCloudWatchAgent.zip"
  creates "/tmp/install.sh"
  cwd '/tmp'
  only_if { ! File.exists? "#{node['aws_cloudwatch']['path']}/bin/amazon-cloudwatch-agent-ctl" }
end


# install aws unified cloudwatch agent
execute 'Install CloudWatch Agent' do
   command "dpkg -i -E ./amazon-cloudwatch-agent.deb"
   creates "#{node['aws_cloudwatch']['path']}/bin/amazon-cloudwatch-agent-ctl"
   cwd '/tmp'
end

# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:configuration-file-path -s

# restart the agent service in the end to ensure that
# the agent will run with the custom configurations
service 'amazon-cloudwatch-agent' do
   action [:enable, :start]
   supports :restart => true, :status => true, :start => true, :stop => true
   provider Chef::Provider::Service::Systemd
   only_if { File.exists? "/usr/bin/dbus-daemon" }
end
