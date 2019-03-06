all: build-image clean build

build-image:
	./utils/run.sh build-image

build:
	./utils/run.sh build-site

clean:
	./utils/run.sh clean

deploy:
	./utils/run.sh github_deploy
