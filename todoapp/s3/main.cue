package main

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/aws/s3"
	"alpha.dagger.io/js/yarn"
)

// Source code of the sample application
source: dagger.#Artifact & dagger.#Input

// Build the source code using Yarn
app: yarn.#Package & {
	"source": source
}

// S3 Bucket name has a default value but can be overriden
bucketName: dagger.#Input & {
	*"todoapp.microstaging.io" | string
}

// Host the application on an S3 bucket
s3bucket: s3.#Object & {
	source: app.build
	target: "s3://\(bucketName)/\(appName)/"
}

// Deploy URL
url: "https://\(bucketName)/\(appName)/" & dagger.#Output
