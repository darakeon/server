MAKEFLAGS += --no-print-directory


# https://blog.nginx.org/blog/rate-limiting-nginx

start:
	@cd nginx && docker compose up --build -d

stop:
	@cd nginx && docker compose down --remove-orphans
