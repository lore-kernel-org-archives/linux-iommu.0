From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Tue, 14 Feb 2012 11:44:37 +0100
Message-ID: <20120214104436.GU22598@amd.com>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<201201111041.06017.laurent.pinchart@ideasonboard.com>
	<CAOy7-nOrTESdfG+_njJgcVUAiLuks_21=GFMBK-2b5mK9UJwpg@mail.gmail.com>
	<1717097.bU1IFGjUNt@avalon> <20120210151018.GS22598@amd.com>
	<CAOy7-nNgduFBqYMpLEaTPQ9VQwZ0Z29SzcAoGC6uRWGAPM3_JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOy7-nNgduFBqYMpLEaTPQ9VQwZ0Z29SzcAoGC6uRWGAPM3_JA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James <angweiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 13, 2012 at 09:28:30AM +0800, James wrote:

> >> @@ -28,6 +28,7 @@ obj-$(CONFIG_XEN) =A0 =A0 =A0 =A0 =A0 +=3D xen/
> >>
> >> =A0# regulators early, since some subsystems rely on them to initialize
> >> =A0obj-$(CONFIG_REGULATOR) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D regulator/
> >> +obj-$(CONFIG_IOMMU_SUPPORT) =A0+=3D iommu/
> >>
> >> =A0# tty/ comes before char/ so that the VT console is the boot-time
> >> =A0# default.
> >> @@ -125,7 +126,6 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 +=3D clk/
> >>
> >> =A0obj-$(CONFIG_HWSPINLOCK) =A0 =A0 +=3D hwspinlock/
> >> =A0obj-$(CONFIG_NFC) =A0 =A0 =A0 =A0 =A0 =A0+=3D nfc/
> >> -obj-$(CONFIG_IOMMU_SUPPORT) =A0+=3D iommu/
> >>
> >> =A0# Virtualization drivers
> >> =A0obj-$(CONFIG_VIRT_DRIVERS) =A0 +=3D virt/

I don't see how this patch solves a problem like below.

> [    3.663269] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000058
> [    3.671844] pgd =3D c0004000
> [    3.674682] [00000058] *pgd=3D00000000
> [    3.678527] Internal error: Oops: 5 [#1]
> [    3.682647] Modules linked in:
> [    3.685852] CPU: 0    Tainted: G        W     (3.2.0-rc2 #1)
> [    3.691802] PC is at klist_next+0x10/0xb4
> [    3.696014] LR is at next_device+0x8/0x14
> [    3.700225] pc : [<c03eeac4>]    lr : [<c024deb8>]    psr: 60000013
> [    3.700225] sp : de82de98  ip : 00000000  fp : c04300c0
> [    3.712249] r10: 000003ff  r9 : c05e2c48  r8 : 00000001
> [    3.717742] r7 : c078ed68  r6 : 00000000  r5 : de82deb8  r4 : de82deb8
> [    3.724578] r3 : c031ff60  r2 : 00000000  r1 : de82deb8  r0 : 00000024
> [    3.731414] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt kernel
> [    3.739074] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    3.745117] Process swapper (pid: 1, stack limit =3D 0xde82c2f0)
> [    3.751220] Stack: (0xde82de98 to 0xde82e000)
> [    3.755798] de80:                                                     =
  c031ff60 c04f8ff4
> [    3.764373] dea0: de82deb8 c031ff60 c078ed68 c024deb8 c031ff60 c024df2=
8 00000024 00000000
> [    3.772949] dec0: c04f8ff4 debe8000 00007990 c05e2c40 0000000e c02e957=
8 22222222 debd1660
> [    3.781524] dee0: 00000000 c011801c c05e2c48 c0056368 debe8580 0000000=
3 de893e80 00000000
> [    3.790100] df00: c05e2c7c c05e2c48 c05e2c7c c078c144 c078c144 0000000=
0 00000000 00000000
> [    3.798675] df20: 00000000 c024e800 c024e7ec c024d720 00000000 c05e2c4=
8 c05e2c7c c078c144
> [    3.807281] df40: 00000000 c024d844 c078c144 de82df58 c024d7dc c024c9a=
0 de825060 de888898
> [    3.815856] df60: c078c144 c078c144 debd3ec0 c0781a10 00000000 c024d02=
c c04f8fef c05fc430
> [    3.824432] df80: de81b040 c078c144 c05d9168 c000dc9c c05c4068 0000000=
0 00000000 c024dd88
> [    3.833007] dfa0: 00000000 c05d904c c05d9168 c000dc9c c05c4068 0000000=
0 00000000 c00087cc
> [    3.841583] dfc0: c05c4068 de81b040 c0797fc0 00000000 c05d904c c05d916=
8 c000dc9c 00000013
> [    3.850158] dfe0: 00000000 c05a77c8 de81b040 00000000 c05a7750 c000dc9=
c 00000000 00002000
> [    3.858764] [<c03eeac4>] (klist_next+0x10/0xb4) from [<c024deb8>] (nex=
t_device+0x8/0x14)
> [    3.867248] [<c024deb8>] (next_device+0x8/0x14) from [<c024df28>] (dri=
ver_find_device+0x64/0x7c)
> [    3.876464] [<c024df28>] (driver_find_device+0x64/0x7c) from [<c02e957=
8>] (isp_probe+0x228/0xa34)
> [    3.885772] [<c02e9578>] (isp_probe+0x228/0xa34) from [<c024e800>] (pl=
atform_drv_probe+0x14/0x18)
> [    3.895111] [<c024e800>] (platform_drv_probe+0x14/0x18) from [<c024d72=
0>] (driver_probe_device+0xc8/0x184)
> [    3.905212] [<c024d720>] (driver_probe_device+0xc8/0x184) from [<c024d=
844>] (__driver_attach+0x68/0x8c)
> [    3.915100] [<c024d844>] (__driver_attach+0x68/0x8c) from [<c024c9a0>]=
 (bus_for_each_dev+0x4c/0x78)
> [    3.924591] [<c024c9a0>] (bus_for_each_dev+0x4c/0x78) from [<c024d02c>=
] (bus_add_driver+0x9c/0x220)
> [    3.934082] [<c024d02c>] (bus_add_driver+0x9c/0x220) from [<c024dd88>]=
 (driver_register+0xa0/0x120)
> [    3.943572] [<c024dd88>] (driver_register+0xa0/0x120) from [<c00087cc>=
] (do_one_initcall+0x90/0x164)
> [    3.953155] [<c00087cc>] (do_one_initcall+0x90/0x164) from [<c05a77c8>=
] (kernel_init+0x78/0x11c)
> [    3.962402] [<c05a77c8>] (kernel_init+0x78/0x11c) from [<c000dc9c>] (k=
ernel_thread_exit+0x0/0x8)
> [    3.971618] Code: e92d40f8 e1a04000 e5900000 e5946004 (e5907034) =

> [    3.978057] ---[ end trace 1b75b31a2719ed1e ]---
> [    3.983001] Kernel panic - not syncing: Attempted to kill init!

This looks more like data corruption or something. But this is definitly
not caused by some random order in the Makefile.
Please debug this issue down to the real cause. Bisecting may help here.


	Joerg

-- =

AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 436=
32
