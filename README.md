# AWS Unified CloudWatch Cookbook
![Runtime][runtime-badge]
![License][license-badge]

Unofficial Chef Cookbook that install and configure [AWS CloudWatch Logs][aws-cloudwatch-url]
Agent and deploy it's configurations automatically.

## Quickstart

Add this cookbook to your base recipe:

```ruby
cookbook 'aws-cloudwatch', '~> 1.0.0'
```

And update your recipe/role/etc. to include teh install:

    include_recipe 'aws-cloudwatch::default'

You can add files to log by doing:

    aws_cloudwatch_log "/var/log/syslog1234" do
        log_group_name "groupname"
        log_stream_name "streamname"
        timezone "Local"
        timestamp_format "timestampformat"
        encoding "utf-8"
    end

For more deployment details about AWS CloudWatch Logs, please visit the [AWS CloudWatch Unified Agent Documentration][aws-cloudwatch-url].

See something missing? Feel free to open a [pull request](https://github.com/ejhayes/aws-codedeploy-agent/pulls)!

## Testing
You can run some basic smoke tests with:

    chef gem install --no-user-install kitchen-docker
    kitchen test

## Requirements

### Platform

* Ubuntu 16.04

## Attributes

See `attributes/default.rb` for default values.

## Recipes

### default

This recipe will check if all necessary requirements being met, and after
that will call `install` recipe.

### install

This recipe will install AWS CloudWatch Logs Agent.

## License and Author

See `LICENSE` for more details.

## Trademark

Amazon Web Services and AWS are trademarks of Amazon.com, Inc. or
its affiliates in the United States and/or other countries.

   [aws-cloudwatch-url]: https://aws.amazon.com/cloudwatch/
   [license-badge]: https://img.shields.io/badge/license-mit-757575.svg?style=flat-square
   [runtime-badge]: https://img.shields.io/badge/runtime-ruby-orange.svg?style=flat-square
