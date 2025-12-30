Python

* I prefer to use uv for everything (uv add, uv run, etc)
* Do not use old fashioned methods for package management like poetry, pip or easy_install.
* Make sure that there is a pyproject.toml file in the root directory.
* If there isn't a pyproject.toml file, create one using uv by running uv init.

## Package Management

- ONLY use uv, NEVER pip
- Installation: uv add package
- Running tools: uv run tool
- Upgrading: uv add --dev package --upgrade-package package
- FORBIDDEN: uv pip install, @latest syntax

