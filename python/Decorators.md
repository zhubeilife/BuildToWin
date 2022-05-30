# Decorators

[Link](https://www.programiz.com/python-programming/decorator)

## Decorators in Python

Python has an interesting feature called decorators to add functionality to an existing code.

This is also called `metaprogramming` because a part of the program tries to modify another part of the program at compile time.

## Prerequisites for learning decorators

everything in Python are objects, so for function

```python
def is_called():
    def is_returned():
        print("Hello")
    return is_returned


new = is_called()

# Outputs "Hello"
new()
# new = is_called() = is_return
# new() = is_return()
```

## Getting back to Decorators

Basically, a decorator takes in a function, adds some functionality and returns it.

```python
def make_pretty(func):
    def inner():
        print("I got decorated")
        func()
    return inner


def ordinary():
    print("I am ordinary")
```

```shell
>>> pretty = make_pretty(ordinary)
>>> pretty()
I got decorated
I am ordinary
```

We can use the @ symbol along with the name of the decorator function and place it above the definition of the function to be decorated. For example,

```python
def make_pretty(func):
    def inner():
        print("I got decorated")
        func()
    return inner

@make_pretty
def ordinary():
    print("I am ordinary")
```

## Decorating Functions with Parameters

```python
def smart_divide(func):
    def inner(a, b):
        return func(a, b) 
    return inner()

@smart_divide
def divide(a, b):
    return a / b

# The same as
divide(2, 0)
# as inner(2, 0)
```

for inner func with params we can write as `function(*args, **kwargs)` 
```python
def works_for_all(func):
    def inner(*args, **kwargs):
        print("I can decorate any function")
        return func(*args, **kwargs)
    return inner
```

## Chaining Decorators in Python

```python
def star(func):
    def inner(*args, **kwargs):
        print("*" * 30)
        func(*args, **kwargs)
        print("*" * 30)
    return inner


def percent(func):
    def inner(*args, **kwargs):
        print("%" * 30)
        func(*args, **kwargs)
        print("%" * 30)
    return inner


@star
@percent
def printer(msg):
    print(msg)


printer("Hello")
```

The same as `printer = star(percent(printer))`

## Wrapper with params

```python
def logger(text):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator

@logger('DEBUG')
def today():
    print('2015-3-25')
```
