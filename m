From: Li Wang <liwang@ubuntukylin.com>
Subject: Kernel panic or hang for Linaro Linux kernel 3.15 on arndale exynos5250
Date: Thu, 12 Jun 2014 11:19:08 +0800
Message-ID: <53991C2C.6030006@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, pullip.cho@samsung.com, tushar.behera@linaro.org, Rahul.Sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi,
   I am running lubuntu 14.04 with the latest Linaro kernel 
(git.linaro.org/kernel/linux-linaro-tracking)
on arndale,  I found once X is started ('xinit' is enough) , any one of 
the following operations will
very easily cause kernel panic or hang,
(1) Ctrl+Alt+F1 and Alt+F7 switch between graphic mode and text mode;
(2) 'xinit' to start graphic mode, then 'exit' to quit graphic mode;
(3) After login into Lunbuntu desktop, switch user account to login;

The kernel is compiled by using the 'exynos_defconfig' and 
'exynos5250-arndale.dts'.
Sometimes the kernel hang without any response, sometimes the kernel
panic with messages below,

[   72.675919] Unable to handle kernel paging request at virtual address 
72643d5
[   72.676016] pgd = e8bdc000
[   72.676055] [72643d45] *pgd=00000000
[   72.676111] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   72.676181] Modules linked in:
[   72.676231] CPU: 0 PID: 3840 Comm: udev-acl.ck Not tainted 
3.15.0-rc8-dirty 2
[   72.682703] task: e93b0c00 ti: e88fe000 task.ti: e88fe000
[   72.688091] PC is at strnlen+0xc/0x54
[   72.691733] LR is at string.isra.4+0x2c/0xcc
...
[<c01c63c0>] (strnlen) from [<c01c7f34>] (string.isra.4+0x2c/0xc)
[   73.296125] [<c01c7f34>] (string.isra.4) from [<c01c92e4>] 
(vsnprintf+0x180/)
[   73.303676] [<c01c92e4>] (vsnprintf) from [<c01c9570>] 
(sprintf+0x24/0x34)
[   73.310536] [<c01c9570>] (sprintf) from [<c025f9fc>] 
(uevent_show+0xcc/0x100)
[   73.317651] [<c025f9fc>] (uevent_show) from [<c026004c>] 
(dev_attr_show+0x20)
[   73.325204] [<c026004c>] (dev_attr_show) from [<c0114ed0>] 
(sysfs_kf_seq_sho)
[   73.333276] [<c0114ed0>] (sysfs_kf_seq_show) from [<c0113cb4>] 
(kernfs_seq_s)
[   73.341522] [<c0113cb4>] (kernfs_seq_show) from [<c00d9670>] 
(seq_read+0x1c0)
[   73.349160] [<c00d9670>] (seq_read) from [<c00bb204>] 
(vfs_read+0x9c/0x12c)
[   73.356103] [<c00bb204>] (vfs_read) from [<c00bb3d0>] 
(SyS_read+0x44/0x84)
[   73.362961] [<c00bb3d0>] (SyS_read) from [<c000e420>] 
(ret_fast_syscall+0x0/)
[   73.370423] Code: e12fff1e e3510000 01a00001 012fff1e (e5d02000)

or sometimes with below,

[   55.480788] Unable to handle kernel NULL pointer dereference ac
[   55.480896] pgd = e9b84000
[   55.480935] [0000026c] *pgd=00000000
[   55.480991] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   55.481061] Modules linked in:
[   55.481155] CPU: 1 PID: 3488 Comm: Xorg Not tainted 3.15.0-rc8-dirty #12
[   55.487835] task: ea1aa400 ti: e8f54000 task.ti: e8f54000
[   55.493222] PC is at evdev_poll+0x28/0x64
[   55.497218] LR is at do_select+0x328/0x650
[   55.501291] pc : [<c02eb088>]    lr : [<c00cb2dc>]    psr: 600f0013
[   55.501291] sp : e8f55b30  ip : e9bc4900  fp : c02eb060
[   55.512747] r10: e9bc4900  r9 : 00000000  r8 : 00003c00
[   55.517955] r7 : 0000000e  r6 : 00000016  r5 : 00000000  r4 : e9355000
[   55.524465] r3 : 00000000  r2 : e8f55bb4  r1 : 00000028  r0 : e9bc4900
[   55.530976] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment user
[   55.538093] Control: 10c5387d  Table: 69b8406a  DAC: 00000015
...
[<c02eb088>] (evdev_poll) from [<c00cb2dc>] (do_select+0x328/0x6)
[   56.505313] [<c00cb2dc>] (do_select) from [<c00cb754>] 
(core_sys_select+0x15)
[   56.513037] [<c00cb754>] (core_sys_select) from [<c00cb9d4>] 
(SyS_select+0xc)
[   56.520764] [<c00cb9d4>] (SyS_select) from [<c000e420>] 
(ret_fast_syscall+0x)
[   56.528397] Code: e2851028 e3530000 13750028 1a00000c (e5d5326c)
[   56.534547] ---[ end trace 6b03dd550054bcfd ]---

Any suggestion on how to fix this is appreciated.

Cheers,
