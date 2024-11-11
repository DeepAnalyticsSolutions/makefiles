# Content for the package setup file
SETUP_TEMPLATE = "from setuptools import setup\nfrom setuptools import find_packages\n\nwith open('requirements.txt') as f:\n\tcontent = f.readlines()\nrequirements = [x.strip() for x in content]\n\nsetup(name='$(PACK_NAME)',\n\tversion='',\n\tdescription='',\n\turl='',\n\tauthor='',\n\tauthor_email='',\n\tlicense='',\n\tpackages=find_packages(),\n\tinstall_requires=requirements,\n\tzip_safe=False)"

# Default values
ENV_NAME = env
PACK_NAME = pack
PYTHON_VERSION = python3
PIP_VERSION = pip3
OPTIONS = -e

# Initialize virtual environment with ENV_NAME
init_env:
	$(PYTHON_VERSION) -m venv $(ENV_NAME)

# Minimal structure for Python package
init_package:
	mkdir -p $(PACK_NAME)/$(PACK_NAME); \
	cd $(PACK_NAME); \
	echo $(SETUP_TEMPLATE) > setup.py; \
	cd $(PACK_NAME); \
	touch __init__.py lib.py

# Create requirements.txt with all the dependencies
requirements:
	$(PIP_VERSION) freeze > $(PACK_NAME)/requirements.txt

# Install the package PACK_NAME
install:
	$(PIP_VERSION) install $(OPTIONS) ./$(PACK_NAME)

# Uninstall the package
uninstall:
	$(PIP_VERSION) uninstall -y $(PACK_NAME)

# Print configuration
config:
	@echo "Environment name: $(ENV_NAME)"
	@echo "Package name: $(PACK_NAME)"
	@echo "Python version: $(PYTHON_VERSION)"
	@echo "Pip version: $(PIP_VERSION)"

# Clean up environment and package directory
clean:
	rm -rf $(ENV_NAME) $(PACK_NAME)