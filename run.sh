# create security policies file (policies.json)

# create security role in AWS using IAM
aws iam create-role \
  --role-name lambda-sample \
  --assume-role-policy-document file://policies.json \
  | tee logs/role.log

# create a zip file including the content
zip function.zip index.js

# create lamba function
aws lambda create-function \
  --function-name hello-cli \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs12.x \
  --role arn:aws:iam::192395167570:role/lambda-sample \
  | tee logs/lambda-create.log

# invoke lambda
aws lambda invoke \
  --function-name hello-cli \
  --log-type Tail \
  logs/lambda-exec.log

# update lambda function
zip function.zip index.js

aws lambda update-function-code \
  --zip-file fileb://function.zip \
  --function-name hello-cli \
  --publish \
  | tee logs/lambda-update.log

# remove resources
aws lambda delete-function \
  --function-name hello-cli

aws iam delete-role \
  --role-name lambda-sample