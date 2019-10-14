#!/bin/bash
#
# auth-init.sh
# Waits for Mongo to start, then creates the initial admin and database users.
#
# Adapted from:
# https://github.com/tutumcloud/mongodb/blob/master/3.2/set_mongodb_password.sh
#

# _js_escape 'some "string" value'
# _js_escape() {
# 	jq --null-input --arg 'str' "$1" '$str'
# }

ADMIN_USER=${MONGO_INITDB_ROOT_USERNAME:-"admin"}
ADMIN_PASS=${MONGO_INITDB_ROOT_PASSWORD:-"admin"}

RET=1
COUNT=0

while [[ $COUNT -lt 6 && $RET -ne 0 ]]; do
	echo "=> Waiting for MongoDB service startup..."
	sleep 5
	mongo admin --eval "help" >/dev/null 2>&1
	RET=$?
	COUNT=$((COUNT+1))
done

if [[ $RET -ne 0 ]]; then
	echo "=> Failed to connect to MongoDB service"
	exit 1
fi

echo "=> Connected!"

#
# Localhost exception allows this to succeed only once
# SEE: https://docs.mongodb.com/manual/core/security-users/#localhost-exception
#
# echo "=> Creating user administrator in admin database..."
# mongo admin << EOF
# db.createUser({user: "$ADMIN_USER", pwd: "$ADMIN_PASS", roles: [{role: "userAdminAnyDatabase", db: "admin"}]})
# EOF
# RET=$?

# if [[ $RET -ne 0 ]]; then
# 	echo "=> Cannot create user administrator; probably already exists"
# else
# 	echo "=> Success!"
# fi

# echo "=> Verifying user administrator in admin database..."
# mongo admin -u "$ADMIN_USER" -p "$ADMIN_PASS" --authenticationDatabase "admin"
# RET=$?

# if [[ $RET -ne 0 ]]; then
# 	echo "=> Cannot authenticate user administrator"
# 	exit 2
# fi

# echo "=> Success!"

if 	[ -z "$MONGO_APPDB_DATABASE" ] || \
	[ -z "$MONGO_APPDB_PASSWORD" ] || [ -z "$MONGO_APPDB_USERNAME" ]; then
	exit 0
fi

echo "=> Creating user ${MONGO_APPDB_USERNAME} in ${MONGO_APPDB_DATABASE} database..."
mongo -u "$ADMIN_USER" -p "$ADMIN_PASS" --authenticationDatabase "admin" << EOF
use $MONGO_APPDB_DATABASE
db.createUser({user: "$MONGO_APPDB_USERNAME", pwd: "$MONGO_APPDB_PASSWORD", roles: [{role: "readWrite", db: "$MONGO_APPDB_DATABASE"}]})
EOF
RET=$?

if [[ $RET -ne 0 ]]; then
	echo "=> Cannot create database user; probably already exists"
else
	echo "=> Success!"
fi
