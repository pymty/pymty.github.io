#!/usr/bin/env bash




if [[ ! -d "$PWD/.git" ]]; then
    echo "Execute this script from the root of the repository" >&2
    exit 1
fi

TAG=pymty-site
DOCKERFILE=utils/Dockerfile
AUTO_PORT=8080

dockerRun(){
    docker run --mount="type=bind,src=$PWD,dst=/site"  -ti $TAG  $*
}


showHelp(){
    cat <<EOF
PyMTY run.sh
-------------
     Options:

        help|--help|-h)
          Show this message.

        auto)

          Run nikola auto and export the port $AUTO_PORT.

        bash)

          Run a bash interactive session in the nikola container.

        build-image)

          Build the docker image to generate the site.

        build-site)

          Run nikola build inside the container with the correct mount points.

        github_deploy)

          Run nikola github_deploy on a container with a bind mounting your $HOME/.ssh into the container.

        - *)
          Pass the argments into the docker image entrypoint (after the dash).

EOF
}


case "$1" in
    help|--help|-h)
        showHelp
        ;;
    "auto")
        docker run \
               --mount="type=bind,src=$PWD,dst=/site" \
               -p $AUTO_PORT:$AUTO_PORT -ti $TAG  auto -a 0.0.0.0 -p $AUTO_PORT
        ;;
    "bash")
        dockerRun bash
        ;;

    "build-image")
        docker build --tag $TAG \
               --file $DOCKERFILE \
               --build-arg UID=$(id -u) \
               --build-arg GID=$(id -g) \
               --build-arg USER=$USER .
        ;;
    "build-site")
        dockerRun build
        ;;
    "clean")
        dockerRun clean
        ;;
    "github_deploy")
        docker run \
             --mount="type=bind,src=$PWD,dst=/site" \
             --mount="type=bind,src=$HOME/.ssh,dst=/home/$USER/.ssh" \
             -ti \
             $TAG  github_deploy

        ;;


    -)
        shift
        dockerRun $*
        ;;
    *)
        echo "==============================================" >&2
        echo "Error: Invalid option" >&2
        showHelp >&2
        echo "==============================================" >&2
        exit 1
esac
