# Variables
PYTHON := python3
PIP := pip
FLASK_APP := app.py
FLASK_ENV := development
VENDOR_DIR := vendor

# Default target: Run the Flask app
.PHONY: run
run: $(VENDOR_DIR)/.installed
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) PYTHONPATH=$(VENDOR_DIR) $(PYTHON) -m flask run -p 3002

# Target to install dependencies
$(VENDOR_DIR)/.installed: requirements.txt
	@echo "Installing dependencies to $(VENDOR_DIR)..."
	$(PIP) install --target=$(VENDOR_DIR) -r requirements.txt
	@touch $(VENDOR_DIR)/.installed

# Clean up vendor directory
.PHONY: clean
clean:
	rm -rf $(VENDOR_DIR) $(VENDOR_DIR)/.installed

# Install dependencies without running the app
.PHONY: deps
deps: $(VENDOR_DIR)/.installed
	@echo "Dependencies installed."

# Initialize the database (migration)
.PHONY: db-init
db-init: $(VENDOR_DIR)/.installed
	PYTHONPATH=$(VENDOR_DIR) FLASK_APP=$(FLASK_APP) $(PYTHON) -m flask db init

# Migrate the database (generate migrations)
.PHONY: db-migrate
db-migrate: $(VENDOR_DIR)/.installed
	PYTHONPATH=$(VENDOR_DIR) FLASK_APP=$(FLASK_APP) $(PYTHON) -m flask db migrate

# Upgrade the database (apply migrations)
.PHONY: db-upgrade
db-upgrade: $(VENDOR_DIR)/.installed
	PYTHONPATH=$(VENDOR_DIR) FLASK_APP=$(FLASK_APP) $(PYTHON) -m flask db upgrade

# Rollback the last migration
.PHONY: db-downgrade
db-downgrade: $(VENDOR_DIR)/.installed
	PYTHONPATH=$(VENDOR_DIR) FLASK_APP=$(FLASK_APP) $(PYTHON) -m flask db downgrade
