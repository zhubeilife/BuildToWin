# git断点续传

https://blog.csdn.net/lgfx21/article/details/119144866?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-119144866-blog-113732543.pc_relevant_multi_platform_whitelistv3&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-119144866-blog-113732543.pc_relevant_multi_platform_whitelistv3&utm_relevant_index=1

```bash
git clone xxx  --depth 1
D=5
while true; do
	echo $D
	git fetch --depth $D
	((D=D+5))
done
```
