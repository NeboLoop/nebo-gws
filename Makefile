VERSION ?= $(shell gh release view --repo googleworkspace/cli --json tagName -q '.tagName')

.PHONY: download sync-skills build manifest upload clean help

build: download sync-skills ## Download binary + sync skills

download: ## Download gws binaries and update plugin.json
	./build.sh $(VERSION)

sync-skills: ## Sync skills from upstream gws repo
	./sync-skills.sh $(VERSION)

manifest: ## Show plugin.json
	@cat plugin.json | jq .

upload: ## Upload binaries to NeboLoop (requires SKILL_ID and TOKEN env vars)
	@if [ -z "$$SKILL_ID" ] || [ -z "$$TOKEN" ]; then echo "Usage: SKILL_ID=... TOKEN=... make upload"; exit 1; fi
	@for PLATFORM in darwin-arm64 darwin-amd64 linux-arm64 linux-amd64 windows-amd64; do \
		if [ -d "dist/$$PLATFORM" ]; then \
			BINARY=$$(ls dist/$$PLATFORM/gws* 2>/dev/null | head -1); \
			if [ -n "$$BINARY" ]; then \
				echo "Uploading $$PLATFORM..."; \
				curl --http1.1 -s -X POST "https://neboloop.com/api/v1/developer/apps/$$SKILL_ID/binaries" \
					-H "Authorization: Bearer $$TOKEN" \
					-F "file=@$$BINARY" \
					-F "platform=$$PLATFORM" \
					-F "plugin=@PLUGIN.md" \
				| jq -r 'if .id then "OK" else . end'; \
			fi; \
		fi; \
	done

clean: ## Remove downloaded binaries and skills
	rm -rf dist/ skills/

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
