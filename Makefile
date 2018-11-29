all: clean build

build:
	nikola build

clean:
	nikola clean

deploy:
	nikola github_deploy
