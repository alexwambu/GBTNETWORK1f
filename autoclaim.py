from fastapi import FastAPI
import asyncio

app = FastAPI()

async def auto_claim():
    while True:
        print("⛏️ Auto-claiming mining rewards for wallet 0x1234567890abcdef1234567890abcdef1234561E")
        # TODO: Replace with actual Web3 logic
        await asyncio.sleep(60)

@app.on_event("startup")
async def startup_event():
    asyncio.create_task(auto_claim())

@app.get("/")
async def root():
    return {"status": "GBTNetwork auto-claim service running"}
