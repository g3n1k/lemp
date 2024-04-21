build:
	docker compose build $(d)

stop:
	docker compose stop

down:
	docker compose down

up:
	docker compose up

upd:
	docker compose up -d

restart:
	docker compose restart

ps:
	docker compose ps

in:
	docker compose exec $(d) bash