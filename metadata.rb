name 'aws-cloudwatch'
maintainer 'Eric Hayes'
maintainer_email 'eric@deployfx.com'
license 'MIT'
description 'Install and Configure AWS CloudWatch Unified Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
source_url 'https://github.com/ejhayes/chef-cloudwatch' if respond_to? :source_url
issues_url 'https://github.com/ejhayes/chef-cloudwatch/issues' if respond_to? :issues_url

%w(
   ubuntu
).each do |os|
  supports os
end

chef_version '>= 14.2'
