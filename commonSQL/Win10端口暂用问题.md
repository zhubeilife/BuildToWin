原文链接：https://www.cnblogs.com/liqing1009/p/15354088.html

在启用 Hyper-V 后，总是会产生各种端口被占用的问题

我遇到过的问题就有：

启动 IDEA 时，报错：

java.net.BindException: Address already in use: bind

使用 Clash for Windows 时，Could not connect to Clash Core，日志：

time="2020-07-28T07:08:37+08:00" level=error msg="External controller error: listen tcp 127.0.0.1:9090: bind: An attempt was made to access a socket in a way forbidden by its access permissions."

显然，这两个错误都是端口被占用造成的。

根据IDEA Start Failed: Address already in use - Serge Baranov 的回答，IDEA 会在 6942~6991 中寻找一个端口并 bind。由此可见，错误原因是这 50 个端口都已经被占用。

根据日志内容，第二个问题是 9090 端口被占用造成的

对于一般的端口占用问题，比如我的 27891 被占用，可以先查找出正在使用此端口的进程，再强行终止这个进程（如果失败可以试试以管理员身份）：

Copy
PS C:\Users\hyuuko> netstat -ano | findstr 27891
  TCP    127.0.0.1:8780         127.0.0.1:27891        SYN_SENT        6276
  TCP    127.0.0.1:8802         127.0.0.1:27891        SYN_SENT        6276
PS C:\Users\hyuuko> taskkill /pid 6276 /F
成功: 已终止 PID 为 6276 的进程。
PS C:\Users\hyuuko>
然而，我使用netstat -ano | findstr 端口号命令时，发现 6942~6991 和 9090 并未被某个进程使用。这说明这些端口可能是被系统保留了，比如 Hyper-V。

根据List of TCP and UDP port numbers - Wikipedia所言，tcp/udp 端口号被分为 3 段：

端口类型	范围	用途
周知端口	0 - 1023	提供广泛使用的网络服务类型的系统进程使用
注册端口	1024 - 49151	给用户进程或应用程序使用，比如 IDEA
动态端口	49152-65535	用于私有或定制服务、临时目的以及临时端口的自动分配
Hyper-V 会将动态端口中的几段范围的端口保留给自己使用，用户的应用程序无法使用这些端口。从 Windows Vista 和 Windows Server 2008 起，Windows 将 49152-65535 划分为 动态端口，见Service overview and network port requirements for Windows。然而在某次更新后，Windows 的动态端口范围变成了 1024~15000，我们可以查看动态端口范围和被保留的端口范围：

Copy
# 查看tcp ipv4动态端口范围
PS C:\Users\hyuuko> netsh int ipv4 show dynamicport tcp

协议 tcp 动态端口范围
---------------------------------
启动端口        : 1024
端口数          : 13977

# 查看tcp ipv4端口排除范围（被系统或者我们自己保留的端口）
PS C:\Users\hyuuko> netsh int ipv4 show excludedport tcp

协议 tcp 端口排除范围

开始端口    结束端口
----------    --------
      1578        1677
      1678        1777
太多了这里省略...
      8974        9073
      9074        9173
      9174        9273
太多了这里省略...
     11301       11400
     11401       11500
     50000       50059     *

* - 管理的端口排除。

PS C:\Users\hyuuko>
可以看到，9074~9173 等等范围内的端口被系统保留了（绝对是 Hyper-V 干的！），导致 clash 不能使用 9090 端口。现在知道原因了，有三种解决办法（我用的第二种）

第一种解决办法（不推荐）#
更改 clash 使用的端口，将 9090 改成较高的 29091，可是治标不治本，因为 Hyper-V 下次可能就会将 29091 保留给自己用。再者而这还不能解决 IDEA 的问题，你不能改变 IDEA 想要使用的端口。

第二种解决办法#
先以管理员身份打开 powershell，然后设置 tcp ipv4 的动态端口范围为 49152 开始的 16384 个端口，也就是 49152~65535

Copy
netsh int ipv4 set dynamicport tcp start=49152 num=16384
然后重启电脑。Hyper-V 就会从 49152~65535 范围内保留一部分端口，6942~6991 和 9090 不受影响。

查看一下此时的动态端口范围：

Copy
PS C:\Users\hyuuko> netsh int ipv4 show dynamicport tcp

协议 tcp 动态端口范围
---------------------------------
启动端口        : 49152
端口数          : 16384
第三种解决办法#
先以管理员身份打开 powershell，然后将 9090 等端口设置为排除端口给应用程序使用。

Copy
# 保留 6942~6951 这10个端口给应用程序使用
netsh int ipv4 add excludedportrange protocol=tcp startport=6942 numberofports=10
# 保留 9090 端口给应用程序使用
netsh int ipv4 add excludedportrange protocol=tcp startport=9090 numberofports=1
然后重启电脑。因为 9090 等端口被保留给应用程序使用了，Hyper-V 就无法将 9090 保留给自己使用了。

查看一下此时被保留的端口：

Copy
PS C:\Users\hyuuko> netsh int ipv4 show excludedport tcp

协议 tcp 端口排除范围

开始端口    结束端口
----------    --------
      1578        1677
      1678        1777
太多了这里省略...
      9090        9090     *
太多了这里省略...
     11301       11400
     11401       11500
太多了这里省略...

* - 管理的端口排除。
带星号的就是被管理员保留的端口，可以被应用程序使用

如果要取消保留端口，可以：

Copy
netsh int ipv4 delete excludedportrange protocol=tcp startport=9090 numberofports=1
参考资料#
StackOverflow - Reserve a TCP port in Windows
StackOverflow - What is Administered port exclusions in windows 10?
本文到这里就结束了，有疑问欢迎评论哦😉
