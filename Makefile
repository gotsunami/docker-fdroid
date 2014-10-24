.PHONY: shell

NAME=fdroid
APK_REPO=~/apk

all:
	docker build -t $(NAME) .

shell:
	docker run --rm -ti $(NAME) /bin/bash

update:
	@mkdir -p $(APK_REPO)
	docker run --rm -v $(APK_REPO):/apk/repo fdroid
