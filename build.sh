#!/bin/bash

. /opt/myEnv.sh

user=uknown
USER_UID="$(id -u $user)"
USER_GID="$(id -g $user)"

neo4j_user=neo4j

FILE=/c/Users
if [ -d "$FILE" ]; then
neo4j_user=unknown
fi


NEO4J_UNAME=$neo4j_user
NEO4J_UID="$(id -u $neo4j_user)"
NEO4J_GID="$(id -g $neo4j_user)"
HOST="$(hostname)"

trunk build || exit 1

mkdir -p .build/opt/frontend && \
cp /opt/myEnv.sh .build/opt/myEnv.sh && \
cp Cargo.toml .build/opt/frontend/Cargo.toml && \
cp entrypoint.sh .build/opt/frontend/entrypoint.sh && \
cp index.html .build/opt/frontend/index.html && \
cp -R src .build/opt/frontend/src && \
cp -R dist .build/opt/frontend/dist || exit 1

docker build \
--build-arg HOST="$HOST" --build-arg USER_UID="$USER_UID" --build-arg USER_GID="$USER_GID" \
--build-arg NEO4J_UID="$NEO4J_UID" --build-arg NEO4J_GID="$NEO4J_GID" --build-arg NEO4J_UNAME=$NEO4J_UNAME \
-t localhost:5000/loudsight/yew-app:0.0.1 . || exit 1
