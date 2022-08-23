Related Link: https://superuser.com/questions/35830/back-forward-mouse-buttons-do-not-work-in-vmware-workstation-6-5-guest-os

Find your `.VMX` file for this VM and add this line

```
usb.generic.allowHID = "TRUE"
mouse.vusb.enable = "TRUE"
mouse.vusb.useBasicMouse = "FALSE"
```
