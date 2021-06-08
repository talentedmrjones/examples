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

// Host the application on an S3 bucket
s3bucket: s3.#Sync & {
	source: app.build
	target: "s3://todo.microstaging.io/\(appName)/"
}
