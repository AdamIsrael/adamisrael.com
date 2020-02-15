+++
# Date this page was created.
date = "2020-02-15"

# Project title.
title = "Ubuntu on Thinkpad X1 Gen 7"

# Project summary to display on homepage.
summary = "A guide to running Ubuntu 20.04 on a 7th generation Lenovo Thinkpad X1 laptop."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "ubuntu-matrix.png"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["linux", "thinkpad"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "ubuntu-matrix.png"

+++
# Thinkpad X1 - 7th gen: Ubuntu 20.04 (pre-release)

Last update: 15 Feb 2020

I recently bought a new laptop: a 7th Generation Lenovo Thinkpad X1 Carbon. This page documents the steps to get the in-development release of Ubuntu 20.04 running smoothly on it.

Specs:
![GNOME About](/img/gnome-about.png)


## Audio

Out of the box, audio output worked fine for me. I did have to go into Settings and change the Output Configuration to `Analog Surround 4.0 Output` to take advantage of all four speakers.

Input is another matter. The Intel chipset uses a digital microphone that, as of yet, I haven't been able to get working.

## Fingerprint Scanner

Official support for the fingerprint scanner is in the works and will be delivered via a firmware update.

To enroll, run `fprintd-enroll`:

```bash
$ fprintd-enroll
list_devices failed: No devices available
```

## Firmware

`fwupdmgr` is supposed to allow for firmware updates, but for some reason it hasn't worked for upgrading the firmware but it is useful to see if your firmware is out of date by running `fwupdmgr get-updates`.

In the interim, you can download firmware updates via the [Lenovo drivers page](https://pcsupport.lenovo.com/ca/en/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x1-carbon-7th-gen-type-20qd-20qe/downloads/driver-list/) as a bootable CD image and flash that to a USB stick.

## Suspend/Resume

By default, suspend/resume hangs on the 5.4 kernel (5.4.0-14-generic). To get this working, we need to add a kernel parameter to grub:

```bash
sudo vim /etc/default/grub
```

Append `snd_hda_intel.dmic_detect=0` to GRUB_CMDLINE_LINUX_DEFAULT.

```bash
# Exit vim with :wq!
sudo update-grub
sudo reboot
```

### BIOS

The BIOS supports two sleep options: Windows or Linux. In your BIOS, go to `Config -> Power -> Sleep State`. Linux uses the traditional S3 power state, which powers off everything but RAM, while Windows uses a software-based "modern standby" which works on Linux despite the name.

Modern standby may resume faster but can also increase the power usage while asleep.


## Sources
- https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_7)
- https://wiki.ubuntu.com/Kernel/KernelBootParameters
- 
