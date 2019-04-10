From: Christian Ehrhardt <christian.ehrhardt-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Reporting crash fixed by intel_iommu=igfx_off
Date: Wed, 10 Apr 2019 11:58:04 +0200
Message-ID: <CAATJJ0Lhr5tjTfLRTpuntm-fmG6mT7QUZjVEAr+bvXy-04vzcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,
I was working on an issue [1] triggered by MDEV passthrough to a KVM Guest.
I got recommended to try intel_iommu=igfx_off and it worked like a
charm allowing me to run opencl things in the guest on the device.

[2] still states for intel_iommu=igfx_off "If this fixes anything,
please ensure you file a bug reporting the problem.". While I'm not
sure how important that is to you still I thought to post you a
summary.
Maybe you are collecting a list of affected HW or anything like that?

If you want me to file a bugzilla or provide extra data let me know.
Here all the snippets I think you might consider helpful.

## Kernel Version ##
5.0.0-8-generic (Ubuntu)
The same kernel is active in Host and Guest.

## Crash ##
(before the fix by  intel_iommu=igfx_off)

[  245.284511] DMAR: DRHD: handling fault status reg 2
[  245.284530] DMAR: [DMA Write] Request device [00:02.0] fault addr
8c9128000 [fault reason 23] Unknown
[  245.284560] DMAR: DRHD: handling fault status reg 2
[  245.284579] DMAR: [DMA Write] Request device [00:02.0] fault addr
8c914a000 [fault reason 23] Unknown
[  245.284610] DMAR: DRHD: handling fault status reg 2
[  250.106273] [drm] GPU HANG: ecode 8:0:0xe757fefe, reason: no
progress on rcs0, action: reset
[  250.106274] [drm] GPU hangs can indicate a bug anywhere in the
entire gfx stack, including userspace.
[  250.106275] [drm] Please file a _new_ bug report on
bugs.freedesktop.org against DRI -> DRM/Intel
[  250.106276] [drm] drm/i915 developers can then reassign to the
right component if it's not a kernel issue.
[  250.106276] [drm] The gpu crash dump is required to analyze gpu
hangs, so please always attach it.
[  250.106277] [drm] GPU crash dump saved to /sys/class/drm/card0/error
[  250.106299] i915 0000:00:02.0: Resetting rcs0 for no progress on rcs0
[  251.900704] i915 0000:00:02.0: Resetting chip for no progress on rcs0
[  251.900718] i915 0000:00:02.0: GPU recovery failed


## HW Information ##

CPU: Intel(R) Core(TM) i5-5250U CPU @ 1.60GHz
$ lspci -v -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 6000
(rev 09) (prog-if 00 [VGA controller])
        Subsystem: Intel Corporation HD Graphics 6000
        Flags: bus master, fast devsel, latency 0, IRQ 48
        Memory at f6000000 (64-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: i915
        Kernel modules: i915

## Mediated Devices passthrough setup ##

Enabled on kernel commandline via /etc/default/grub:
  i915.enable_gvt=1 intel_iommu=on drm.debug=0
And loading the modules:
  $ printf "kvmgt\nvfio-iommu-type1\nvfio-mdev" | sudo tee
/etc/initramfs-tools/modules

Update and reboot
 $ sudo update-initramfs -u
 $ sudo update-grub

Then I was creating a UUID for the MDEV
 $ cd /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V4_4
 $ echo 4dd50f26-ec08-11e8-b838-4bc3356865b6 | sudo tee create

Finally I was telling libvirt to use that modifying my guest XML like
 <graphics type='spice'>
   <listen type='none'/>
   <gl enable='yes'/>
 </graphics>
 <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-pci'>
   <source>
     <address uuid='4dd50f26-ec08-11e8-b838-4bc3356865b6'/>
   </source>
 </hostdev>


## guest workload to force-trigger the bug ##

Note: it could happen without it, but that proved to be faster than
waiting for the crash

Install opencl bits and try to use it, that would be:
 $ sudo apt install ocl-icd-libopencl1
 $ sudo apt install opencl-headers
 $ sudo apt install clinfo
 $ sudo apt install beignet
And then run clinfo
 $ clinfo


[1]: https://bugs.freedesktop.org/show_bug.cgi?id=110238
[2]: https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt

P.S. the list won't send me the subscription confirmation - three
tries waited for an hour; so I expect to be at least moderated if not
denied on the list post :-/

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
