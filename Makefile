all: d ur

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
		terraform-docs markdown "$$dir" > "$$dir/README.md" \
	' \;
	@echo "Documentation generation complete!"

ur update-readme: docs
	@echo "Updating root README.md with module READMEs and custom separators..."
	@echo "# Hetzner Terraform Modules" > README.md
	@echo >> README.md
	@echo "Modules for simplifying the creation of resources on Hetzner Cloud and Cloudflare." >> README.md
	@echo >> README.md
	@echo "![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)" >> README.md; \

	@for readme in $$(find modules -type f -name "README.md" | sort); do \
		echo "## Module: $$(basename $$(dirname $$readme))" >> README.md; \
		echo >> README.md; \
		cat $$readme >> README.md; \
		echo >> README.md; \
		echo "![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)" >> README.md; \
		echo >> README.md; \
	done

	@echo "Root README.md updated with custom separators!"

t test:
	@cd test && go test -v

.PHONY: d docs tdi terraform-docs t test ur update-readme
