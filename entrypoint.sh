#!/usr/bin/env bash

set -e

[ ! -f /opt/coin/config.ini ] && cp /opt/config.ini /opt/coin/
[ ! -f /opt/coin/logging.ini ] && cp /opt/logging.ini /opt/coin/

mkdir -p /opt/coin/logs/{default,p2p,rpc}
mkdir -p /opt/coin/p2p

if test $# -eq 0; then
  # start node
  track=${track_account:-1.2.12345}
  /opt/programs/witness_node/witness_node --data-dir /opt/coin --track-account "\"$track\"" &
  echo "Logging to logs/default/default.log ..."
  # wait until ws started
  while ! nc -z -w 1 127.0.0.1 8090; do
    sleep .2
  done
  # wallet
  exec /opt/programs/cli_wallet/cli_wallet --server-rpc-endpoint ws://127.0.0.1:8090 --rpc-http-endpoint 0.0.0.0:8091 --wallet-file /opt/coin/wallet.json
else
  exec $@
fi
