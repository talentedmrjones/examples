package main

import (
	"dagger.io/dagger"
)

repo: dagger.#Artifact

// Load app information from compose file
// Load the docker compose project
compose: #ComposeProject & {
	context: repo
}
