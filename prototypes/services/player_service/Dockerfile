# Use the official AWS Lambda base image for Go
FROM public.ecr.aws/lambda/go:1

# Copy the compiled Go binary into the container
COPY main /var/task/

# Command to run the Lambda function
CMD ["main"]