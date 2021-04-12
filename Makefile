deploy:
	aws --profile ${AWS_PROFILE} s3 sync build/ s3://${AWS_BUCKET}/rumble/
	aws --profile ${AWS_PROFILE} cloudfront create-invalidation --distribution-id ${ID} --paths '/*'
