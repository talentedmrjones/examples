package main

import (
	"dagger.io/dagger"
	"dagger.io/aws/s3"
	"dagger.io/js/yarn"
)

// Source code of the sample application
source: dagger.#Artifact @dagger(input)

// Build the source code using Yarn
app: yarn.#Package & {
	"source": source
}

// S3 Bucket name has a default value but can be overriden
bucketName: *"todoapp.microstaging.io" | string @dagger(input)

// Host the application on an S3 bucket
s3bucket: s3.#Object & {
	always: true
	source: app.build
	target: "s3://\(bucketName)/\(appName)/"
}

url: "http://\(bucketName)/\(appName)/" @dagger(output)
