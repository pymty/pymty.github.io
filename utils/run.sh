#!/usr/bin/env bash




if [[ ! -d "$PWD/.git" ]]; then
    echo "Execute this script from the root of the repository" >&2
    exit 1
fi

TAG=pymty-site
DOCKERFILE=utils/Dockerfile


dockerRun(){
    docker run \
           --mount="type=bind,src=$PWD,dst=/site" \
           --user="$(id -u):$(id -g)" $TAG  $*
}



case "$1" in
    help|--help|-h)
        cat <<EOF
PyMTY run.sh
-------------
     Options:

        help|--help|-h) Show this message

        build-image) Build the docker image to generate the site

        build-site) Run nikola build inside the container with the correct mount points.

        *) Pass the argments into the docker image entrypoint.

EOF
        ;;

    "build-image")
        docker build --tag $TAG --file $DOCKERFILE .
        ;;
    "build-site")
        dockerRun build
        ;;
    "clean")
        dockerRun clean
        ;;
    "github_deploy")
        dockerRun github_deploy
        ;;
    *)
        docker run \
               --mount="type=bind,src=$PWD,dst=/site" \
               --user="$(id -u):$(id -g)" -ti $TAG  $*
        ;;
esac
