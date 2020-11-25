**API Gateway Permissions for staging variables**
aws --profile personal lambda add-permission \
--statement-id cf8d6a-8965-5ae0-9c-e0a8f17a51 \
--action lambda:InvokeFunction \
--function-name "arn:aws:lambda:us-west-2:710246576414:function:bitcoin_bootstrap_api:stage" \
--principal apigateway.amazonaws.com \
--source-arn "arn:aws:execute-api:us-west-2:710246576414:bapm03al05/*/api"

aws --profile personal lambda add-permission \
--statement-id cf8d6a-8965-5ae0-9ca3-71e0a8fa51 \
--action lambda:InvokeFunction \
--function-name "arn:aws:lambda:us-west-2:710246576414:function:bitcoin_bootstrap_api:production" \
--principal apigateway.amazonaws.com \
--source-arn "arn:aws:execute-api:us-west-2:710246576414:bapm03al05/*/api"

**YOU MUST SPECIFY THE lambda function arn (not just name) like this:

`arn:aws:lambda:us-west-2:710246576414:function:bitcoin_bootstrap_api::${stageVariables.lambdaAlias}`

when configuring the integration in the gateway interface.

aws lambda add-permission \
--function-name arn:aws:lambda:XXXXXX:your-lambda-function-name \
--source-arn arn:aws:execute-api:us-east-1:YOUR_ACCOUNT_ID:api_id/*/HTTP_METHOD/resource --principal apigateway.amazonaws.com --statement-id apigateway-access --action lambda:InvokeFunction

**Run**

RUBYOPT="-W:no-deprecated" rails server
