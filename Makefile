dc = docker compose
run = $(dc) run --rm

build:
	$(dc) build

push: build
	$(dc) push

app:
	$(run) app

test:
	$(run) app rclone version

bash:
	$(run) app bash
