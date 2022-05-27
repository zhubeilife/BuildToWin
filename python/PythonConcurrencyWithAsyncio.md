# Python Concurrency with aasyncio

## Chapter1 Getting to know asyncio

## Chapter2 asyncio basics

`Running a coroutine`

asyncio.run is doing a few important things in this scenario. First, it creates a brand-new event. Once it successfully does so, it takes whichever coroutine we pass into it and runs it until it completes, returning the result. This function will also do some cleanup of anything that might be left running after the main coroutine finishes. Once everything has finished, it shuts down and closes the event loop.

```python
import asyncio

async def add_one(number: int) -> int:
    return number + 1

async def main() -> None:
    # await 其实就是在调用 async func
    # 会等add_one(1)执行完才会执行回复，也就是会pause main()
    one_plus_one = await add_one(1)
    two_plus_one = await add_one(2)
    print(one_plus_one)
    print(two_plus_one)

asyncio.run(main())
```
