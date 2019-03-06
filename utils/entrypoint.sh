#!/bin/bash

params=( $@ )
NIKOLA="/env/bin/nikola"
case ${params[0]} in
     "bash")
         exec /bin/bash -i
         ;;
     *)
         $NIKOLA ${params[@]}
         ;;
esac
