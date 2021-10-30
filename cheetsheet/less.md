# Less

## search

When you want to search for string1 or string2, use 

```
/string1|string2
```

You said you wanted lines where you find both:

```
/string1.*string2
```

When you do not know the order in the line and want to see the complete line, you will need

```
/.*(string1.*string2|string2.*string1).*
```
