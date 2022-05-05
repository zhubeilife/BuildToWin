# [How To Add An Application In The List Of Open With Applications In Ubuntu](https://itsfoss.com/add-application-list-open-applications-ubuntu-1310/)

this tutorial is demonstrated with Pinta image editor. You can use the similar steps for any program. Just change the Pinta with your application names in the commands we are going to use.

To add any program in the list of default list of open with applications, open a terminal and use the following command:

```bash
sudo gedit /usr/share/applications/XXX.desktop
```

Please note two things. In XXX.desktop, XXX is the name of your application. And then use of gedit. You can use any other editor. I used Vim. If you use Gedit, it will dispaly some warning messages in the terminal but will open the file in a GUI.

In this desktop file, look for a line that looks like this:

```txt
Exec=XXX
```

If you have something like this, replace this line with:

```txt
Exec=XXX %F
```

Save it and exit/close the desktop file. No need to restart or anything. It should be working instantly.
