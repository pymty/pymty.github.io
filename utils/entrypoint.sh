#!/bin/bash
params=( $@ )

case ${params[0]} in
     "bash")
         exec /bin/bash -i
         ;;
     *)
         source /env/bin/activate
         nikola ${params[@]}
         ;;
esac
