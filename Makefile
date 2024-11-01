
tdi terraform-docs:
	@if -v terraform-docs > /dev/null 2>&1; then \
		echo "installing terraform-docs"; \
		go install github.com/terraform-docs/terraform-docs@latest; \
	else \
		echo "terrafrom-docs allready installed"; \
	fi

d docs:
	@echo "Generating terraform-docs for modules..."
	@find modules -type f -name "main.tf" -exec sh -c ' \
		dir="$$(dirname "{}")"; \
		echo "Generating docs for $$dir"; \
		terraform-docs markdown table "$$dir" > "$$dir/README.md" \
	' \;
	@echo "Documentation generation complete!"

t test:
	@cd test && go test -v

.PHONY: d docs tdi terraform-docs t test
