aws = require 'aws-sdk'
config = require './config'

aws.config.update
  accessKeyId: config.aws_access_key_id
  secretAccessKey: config.aws_access_key
  region: config.aws_region

glacierSettings =
  apiVersion: '2012-06-01'
glacierSettings.endpoint = config.endpoint if config.endpoint
module.exports = new aws.Glacier glacierSettings

