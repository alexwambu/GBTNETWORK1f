#!/bin/bash
set -e

DATA_DIR=/root/.ethereum
NETWORK_ID=999
RPC_PORT=9636
COINBASE=0x1234567890abcdef1234567890abcdef1234561E

if [ ! -d "$DATA_DIR/geth" ]; then
  echo "⚡ Initializing new chain..."
  geth --datadir $DATA_DIR init /app/genesis.json
fi

echo "🚀 Starting GBTNetwork node..."
geth --datadir $DATA_DIR \
  --networkid $NETWORK_ID \
  --http --http.addr "0.0.0.0" --http.port $RPC_PORT \
  --http.api "eth,net,web3,miner,personal" \
  --allow-insecure-unlock \
  --unlock $COINBASE --password /app/password.txt \
  --mine --miner.threads=1 \
  --syncmode 'full' \
  --verbosity 3 > /app/geth.log 2>&1 &

sleep 5
echo "✅ Node running on port $RPC_PORT"

echo "⚡ Starting auto-claim service..."
exec uvicorn autoclaim:app --host 0.0.0.0 --port 8000 --reload
