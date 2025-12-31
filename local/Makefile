MAKEFLAGS += --no-print-directory


start:
	@cd nginx && docker compose up --build -d

stop:
	@cd nginx && docker compose down --remove-orphans
