#
# Cookbook Name:: aws-cloudwatch
# Resources:: aws_cloudwatch_log
#

resource_name :aws_cloudwatch_log
provides :aws_cloudwatch_log

property :log_file, String, required: true, name_property: true
property :log_group_name, String, required: true
property :log_stream_name, String, required: true
property :timezone, String, required: true, equal_to: %w(Local UTC)
property :timestamp_format, String, required: true
property :encoding, String, required: true, default: 'utf-8', equal_to: %w(utf-8 ascii big5 euc-jp euc-kr gbk gb18030 ibm866 iso2022-jp iso8859-2 iso8859-3 iso8859-4 iso8859-5 iso8859-6 iso8859-7 iso8859-8 iso8859-8-i iso8859-10 iso8859-13 iso8859-14 iso8859-15 iso8859-16 koi8-r koi8-u macintosh shift_jis utf-8 utf-16 windows-874 windows-1250 windows-1251 windows-1252 windows-1253 windows-1254 windows-1255 windows-1256 windows-1257 windows-1258 x-mac-cyrillic)

action :create do
  # As we're using the accumulator pattern we need to shove everything
  # into the root run context so each of the sections can find the parent
  Chef::Log.info "Adding configuration for #{cookbook_name}"
  with_run_context :root do
    edit_resource(:template, node['aws_cloudwatch']['config_file']) do |new_resource|
      self.cookbook_name = 'aws-cloudwatch'
      source 'awslogs.conf.erb'
      variables[:logs] ||= []
      variables[:logs].push({
        log_file: new_resource.log_file,
        log_group_name: new_resource.log_group_name,
        log_stream_name: new_resource.log_stream_name,
        timezone: new_resource.timezone,
        timestamp_format: new_resource.timestamp_format,
        encoding: new_resource.encoding
    })


      action :nothing
      delayed_action :create
      notifies :restart, 'service[amazon-cloudwatch-agent]', :delayed
    end
  end
end