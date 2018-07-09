#
# Cookbook Name:: aws-cloudwatch
# Attributes:: default
#

# AWS Credentials
default['aws_cloudwatch']['region'] = nil
default['aws_cloudwatch']['aws_access_key_id'] = nil
default['aws_cloudwatch']['aws_secret_access_key'] = nil

# AWS CloudWatch Logs
default['aws_cloudwatch']['source_zip'] = 'https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip'
default['aws_cloudwatch']['config_file'] = '/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json'
default['aws_cloudwatch']['path'] = '/opt/aws/amazon-cloudwatch-agent'
