#!/bin/bash


session_duration=${SESSION_LENGTH:-4h}
pass_value=${NOTEBOOK_PASS:-sha1:92cf1ff5134d:eecd093c46b3b5b98285ab0238ebe929e640b2a8}

cat > /home/app/.jupyter/jupyter_notebook_config.json <<EOF
{"NotebookApp": {"nbserver_extensions": {"jupyter_http_over_ws": true},"password": "${pass_value}"}}
EOF

cmd=$1
case $cmd in
app)
  jupyter notebook --notebook-dir=/opt/app --ip=0.0.0.0 --no-browser --allow-root
  ;;
job)
  jupyter notebook --notebook-dir=/opt/app --ip=0.0.0.0 --no-browser --allow-root &
  echo session duration ${session_duration}
  sleep ${session_duration}
  ;;
*)
  echo overriding jupyter command with "$@"
  exec "$@"
  ;;
esac
