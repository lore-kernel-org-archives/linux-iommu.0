Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25DC3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 10:07:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FB0246A0
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hyfx2Wn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FB0246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 054D220468;
	Fri, 28 Feb 2020 10:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMoQb7V-EKOL; Fri, 28 Feb 2020 10:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 394E820463;
	Fri, 28 Feb 2020 10:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17890C1D84;
	Fri, 28 Feb 2020 10:07:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC75C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 10:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8023086BA4
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 10:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JHPx79j4kpL for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 10:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF1B686274
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mxthWT8iGfMcFCSMb0DuPtbxBTFZOiV8/YtzkXALVPg=; b=Hyfx2Wn8/g5UUN3H1bMv2cDPm
 dfKm8NtXDwLrIm/dOIISgU6mFFZjPwZIvjghkuUoPlzNcL+1zSM6BdKAo2jrma1FdNDtWAhuuEQ5t
 7Q7cK4M9VSIpDAfr+dQdg8us1zjJPMcKenWx5IqQlWGUnqDQvkpLoOBSxirmpm8sSA1ATZe7hSmef
 Qz2eqOFNl7+4bVHst+h8CA93aDOSWEBSA8gQop2QtgkzTuI/lzzi1vkzm83Pk3rkdwk1lz0Re/OGB
 gPT6OQsFpwvdbYLspc1ffgR4c0/4Od62NE1/CgKl+dUwUecurDiwN7ZEqupIsv546Wba1z/G4hG/q
 ZkoUzSprA==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58012)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j7cXg-00039x-Ku; Fri, 28 Feb 2020 10:06:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j7cXc-0001tJ-PR; Fri, 28 Feb 2020 10:06:44 +0000
Date: Fri, 28 Feb 2020 10:06:44 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200228100644.GT25745@shell.armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <f0fc4c8c-4475-e77f-da6d-e068e7993568@linux.intel.com>
 <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Feb 28, 2020 at 09:33:40AM +0000, John Garry wrote:
> On 28/02/2020 02:16, Lu Baolu wrote:
> > Hi,
> > =

> > On 2020/2/27 19:57, Russell King wrote:
> > > On the LX2160A, there are lots (about 160) of IOMMU messages produced
> > > during boot; this is excessive.=A0 Reduce the severity of these messa=
ges
> > > to debug level.
> > > =

> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > ---
> > > =A0 drivers/iommu/iommu.c | 4 ++--
> > > =A0 1 file changed, 2 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 3ead597e1c57..304281ec623b 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -741,7 +741,7 @@ int iommu_group_add_device(struct iommu_group
> > > *group, struct device *dev)
> > > =A0=A0=A0=A0=A0 trace_add_device_to_group(group->id, dev);
> > > -=A0=A0=A0 dev_info(dev, "Adding to iommu group %d\n", group->id);
> > > +=A0=A0=A0 dev_dbg(dev, "Adding to iommu group %d\n", group->id);
> > =

> > I'm not strongly against this. But to me this message seems to be a good
> > indicator that a device was probed successfully by the iommu subsystem.
> > Keeping it in the default kernel message always helps to the kernel
> > debugging.
> > =

> =

> I would tend to agree.

Here's the boot messages.  Notice how many of these "Adding to iommu
group" messages there are:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.5.0+ (rmk@rmk-PC) (gcc version 4.9.2 (GCC)) =
#655 SMP PREEMPT Fri Feb 28 09:54:47 GMT 2020
[    0.000000] Machine model: SolidRun LX2160A Clearfog CX
[    0.000000] earlycon: pl11 at MMIO32 0x00000000021c0000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x00000000f9c00000
[    0.000000] On node 0 totalpages: 1555968
[    0.000000]   DMA zone: 4096 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 262144 pages, LIFO batch:63
[    0.000000]   DMA32 zone: 3832 pages used for memmap
[    0.000000]   DMA32 zone: 245248 pages, LIFO batch:63
[    0.000000]   Normal zone: 16384 pages used for memmap
[    0.000000]   Normal zone: 1048576 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 31 pages/cpu s88968 r8192 d29816 u126976
[    0.000000] pcpu-alloc: s88968 r8192 d29816 u126976 alloc=3D31*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06=
 [0] 07 =

[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14=
 [0] 15 =

[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] CPU features: detected: ARM erratum 1319367
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 15316=
56
[    0.000000] Kernel command line: console=3DttyAMA0,115200 root=3DPARTUUI=
D=3Dc7837e2f-02 rootwait earlycon=3Dpl011,mmio32,0x21c0000 ramdisk_size=3D0=
 pci=3Dpcie_bus_perf arm_smmu.disable_bypass=3D0 iommu.passthrough=3D0
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0xbbfff000-0xbffff000] (64MB)
[    0.000000] Memory: 5991500K/6223872K available (10172K kernel code, 137=
6K rwdata, 3888K rodata, 960K init, 4326K bss, 199604K reserved, 32768K cma=
-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=
=3D16.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000062000=
00
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 65536 Devices @2178d00000 =
(flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000002178cd0000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000002178=
ce0000
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0x5c409fb33, max_idle_ns: 440795203156 ns
[    0.000002] sched_clock: 56 bits at 25MHz, resolution 39ns, wraps every =
4398046511103ns
[    0.006921] Console: colour dummy device 80x25
[    0.010093] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.016605] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.019421] ... MAX_LOCK_DEPTH:          48
[    0.022329] ... MAX_LOCKDEP_KEYS:        8192
[    0.025408] ... CLASSHASH_SIZE:          4096
[    0.028491] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.031659] ... MAX_LOCKDEP_CHAINS:      65536
[    0.034830] ... CHAINHASH_SIZE:          32768
[    0.037997]  memory used by lock dependency info: 3509 kB
[    0.042135]  per task-struct memory footprint: 1920 bytes
[    0.046292] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 50.00 BogoMIPS (lpj=3D100000)
[    0.055443] pid_max: default: 32768 minimum: 301
[    0.058844] LSM: Security Framework initializing
[    0.062241] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
[    0.068602] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes, linear)
[    0.099452] ASID allocator initialised with 32768 entries
[    0.111615] rcu: Hierarchical SRCU implementation.
[    0.119672] Platform MSI: gic-its@6020000 domain created
[    0.123765] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000 domai=
n created
[    0.130045] fsl-mc MSI: /interrupt-controller@6000000/gic-its@6020000 do=
main created
[    0.136572] EFI services will not be available.
[    0.148587] smp: Bringing up secondary CPUs ...
[    0.180732] Detected PIPT I-cache on CPU1
[    0.180749] GICv3: CPU1: found redistributor 1 region 0:0x00000000062200=
00
[    0.180761] GICv3: CPU1: using allocated LPI pending table @0x0000002178=
cf0000
[    0.180781] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.212781] Detected PIPT I-cache on CPU2
[    0.212797] GICv3: CPU2: found redistributor 100 region 0:0x000000000624=
0000
[    0.212810] GICv3: CPU2: using allocated LPI pending table @0x0000002178=
d80000
[    0.212830] CPU2: Booted secondary processor 0x0000000100 [0x410fd083]
[    0.244832] Detected PIPT I-cache on CPU3
[    0.244844] GICv3: CPU3: found redistributor 101 region 0:0x000000000626=
0000
[    0.244855] GICv3: CPU3: using allocated LPI pending table @0x0000002178=
d90000
[    0.244871] CPU3: Booted secondary processor 0x0000000101 [0x410fd083]
[    0.276894] Detected PIPT I-cache on CPU4
[    0.276910] GICv3: CPU4: found redistributor 200 region 0:0x000000000628=
0000
[    0.276922] GICv3: CPU4: using allocated LPI pending table @0x0000002178=
da0000
[    0.276941] CPU4: Booted secondary processor 0x0000000200 [0x410fd083]
[    0.308953] Detected PIPT I-cache on CPU5
[    0.308966] GICv3: CPU5: found redistributor 201 region 0:0x00000000062a=
0000
[    0.308978] GICv3: CPU5: using allocated LPI pending table @0x0000002178=
db0000
[    0.308994] CPU5: Booted secondary processor 0x0000000201 [0x410fd083]
[    0.341009] Detected PIPT I-cache on CPU6
[    0.341027] GICv3: CPU6: found redistributor 300 region 0:0x00000000062c=
0000
[    0.341039] GICv3: CPU6: using allocated LPI pending table @0x0000002178=
dc0000
[    0.341058] CPU6: Booted secondary processor 0x0000000300 [0x410fd083]
[    0.373064] Detected PIPT I-cache on CPU7
[    0.373079] GICv3: CPU7: found redistributor 301 region 0:0x00000000062e=
0000
[    0.373091] GICv3: CPU7: using allocated LPI pending table @0x0000002178=
dd0000
[    0.373106] CPU7: Booted secondary processor 0x0000000301 [0x410fd083]
[    0.405124] Detected PIPT I-cache on CPU8
[    0.405143] GICv3: CPU8: found redistributor 400 region 0:0x000000000630=
0000
[    0.405156] GICv3: CPU8: using allocated LPI pending table @0x0000002178=
de0000
[    0.405175] CPU8: Booted secondary processor 0x0000000400 [0x410fd083]
[    0.437179] Detected PIPT I-cache on CPU9
[    0.437195] GICv3: CPU9: found redistributor 401 region 0:0x000000000632=
0000
[    0.437207] GICv3: CPU9: using allocated LPI pending table @0x0000002178=
df0000
[    0.437223] CPU9: Booted secondary processor 0x0000000401 [0x410fd083]
[    0.469240] Detected PIPT I-cache on CPU10
[    0.469261] GICv3: CPU10: found redistributor 500 region 0:0x00000000063=
40000
[    0.469273] GICv3: CPU10: using allocated LPI pending table @0x000000217=
8e00000
[    0.469293] CPU10: Booted secondary processor 0x0000000500 [0x410fd083]
[    0.501296] Detected PIPT I-cache on CPU11
[    0.501314] GICv3: CPU11: found redistributor 501 region 0:0x00000000063=
60000
[    0.501326] GICv3: CPU11: using allocated LPI pending table @0x000000217=
8e10000
[    0.501342] CPU11: Booted secondary processor 0x0000000501 [0x410fd083]
[    0.533362] Detected PIPT I-cache on CPU12
[    0.533385] GICv3: CPU12: found redistributor 600 region 0:0x00000000063=
80000
[    0.533397] GICv3: CPU12: using allocated LPI pending table @0x000000217=
8e20000
[    0.533418] CPU12: Booted secondary processor 0x0000000600 [0x410fd083]
[    0.565408] Detected PIPT I-cache on CPU13
[    0.565427] GICv3: CPU13: found redistributor 601 region 0:0x00000000063=
a0000
[    0.565440] GICv3: CPU13: using allocated LPI pending table @0x000000217=
8e30000
[    0.565455] CPU13: Booted secondary processor 0x0000000601 [0x410fd083]
[    0.597470] Detected PIPT I-cache on CPU14
[    0.597494] GICv3: CPU14: found redistributor 700 region 0:0x00000000063=
c0000
[    0.597507] GICv3: CPU14: using allocated LPI pending table @0x000000217=
8e40000
[    0.597527] CPU14: Booted secondary processor 0x0000000700 [0x410fd083]
[    0.629523] Detected PIPT I-cache on CPU15
[    0.629543] GICv3: CPU15: found redistributor 701 region 0:0x00000000063=
e0000
[    0.629556] GICv3: CPU15: using allocated LPI pending table @0x000000217=
8e50000
[    0.629571] CPU15: Booted secondary processor 0x0000000701 [0x410fd083]
[    0.629684] smp: Brought up 1 node, 16 CPUs
[    0.931457] SMP: Total of 16 processors activated.
[    0.934986] CPU features: detected: 32-bit EL0 Support
[    0.938858] CPU features: detected: CRC32 instructions
[    0.947732] CPU features: emulated: Privileged Access Never (PAN) using =
TTBR0_EL1 switching
[    0.954876] CPU: All CPU(s) started at EL2
[    0.957748] alternatives: patching kernel code
[    0.961954] devtmpfs: initialized
[    0.968138] random: get_random_u32 called from bucket_table_alloc.isra.2=
2+0x88/0x1e0 with crng_init=3D0
[    0.976604] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.985153] futex hash table entries: 4096 (order: 7, 524288 bytes, line=
ar)
[    0.991643] pinctrl core: initialized pinctrl subsystem
[    0.996213] thermal_sys: Registered thermal governor 'step_wise'
[    0.996473] DMI not present or invalid.
[    1.004023] NET: Registered protocol family 16
[    1.008239] DMA: preallocated 256 KiB pool for atomic allocations
[    1.013102] audit: initializing netlink subsys (disabled)
[    1.017340] audit: type=3D2000 audit(0.828:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    1.023873] cpuidle: using governor ladder
[    1.026734] cpuidle: using governor menu
[    1.029477] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.035332] Serial: AMBA PL011 UART driver
[    1.039319] Machine: SolidRun LX2160A Clearfog CX
[    1.042751] SoC family: QorIQ LX2160A
[    1.045135] SoC ID: svr:0x87361010, Revision: 1.0
[    1.049775] 21c0000.serial: ttyAMA0 at MMIO 0x21c0000 (irq =3D 17, base_=
baud =3D 0) is a SBSA
[    1.056765] printk: console [ttyAMA0] enabled
[    1.062890] printk: bootconsole [pl11] disabled
[    1.069745] 21d0000.serial: ttyAMA1 at MMIO 0x21d0000 (irq =3D 18, base_=
baud =3D 0) is a SBSA
[    1.083284] fsl_mc_bus 80c000000.fsl-mc: MC firmware version: 10.18.0
[    1.091046] fsl_mc_dprc dprc.1: DMA mask not set
[    1.104098] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.109500] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    1.114906] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.120298] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    1.127238] cryptd: max_cpu_qlen set to 1000
[    1.132187] iommu: Default domain type: Translated (set via kernel comma=
nd line)
[    1.138411] vgaarb: loaded
[    1.140045] SCSI subsystem initialized
[    1.142660] libata version 3.00 loaded.
[    1.142830] usbcore: registered new interface driver usbfs
[    1.147050] usbcore: registered new interface driver hub
[    1.151152] usbcore: registered new device driver usb
[    1.155269] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery not sup=
ported
[    1.161373] i2c i2c-0: IMX I2C adapter registered
[    1.164914] imx-i2c 2020000.i2c: can't get pinctrl, bus recovery not sup=
ported
[    1.170923] i2c i2c-1: IMX I2C adapter registered
[    1.174438] imx-i2c 2040000.i2c: can't get pinctrl, bus recovery not sup=
ported
[    1.180489] i2c i2c-2: IMX I2C adapter registered
[    1.184034] pps_core: LinuxPPS API ver. 1 registered
[    1.187711] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.195563] PTP clock support registered
[    1.198926] clocksource: Switched to clocksource arch_sys_counter
[    1.409271] VFS: Disk quotas dquot_6.6.0
[    1.411929] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.423147] NET: Registered protocol family 2
[    1.426524] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6,=
 294912 bytes, linear)
[    1.434212] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    1.441038] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes=
, linear)
[    1.452946] TCP: Hash tables configured (established 65536 bind 65536)
[    1.458362] UDP hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    1.464637] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, l=
inear)
[    1.471476] NET: Registered protocol family 1
[    1.474948] RPC: Registered named UNIX socket transport module.
[    1.479561] RPC: Registered udp transport module.
[    1.482958] RPC: Registered tcp transport module.
[    1.486348] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.491485] PCI: CLS 0 bytes, default 64
[    1.495248] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 c=
ounters available
[    1.502280] kvm: Limiting the IPA size due to kernel Virtual Address lim=
it
[    1.507851] kvm [1]: IPA Size Limit: 43bits
[    1.511572] kvm [1]: vgic-v2@c0e0000
[    1.513851] kvm [1]: GIC system register CPU interface enabled
[    1.518687] kvm [1]: vgic interrupt IRQ1
[    1.521608] kvm [1]: Hyp mode initialized successfully
[    1.535818] workingset: timestamp_bits=3D46 max_order=3D21 bucket_order=
=3D0
[    1.549175] NFS: Registering the id_resolver key type
[    1.552967] Key type id_resolver registered
[    1.555844] Key type id_legacy registered
[    1.558661] fuse: init (API version 7.31)
[    1.561605] 9p: Installing v9fs 9p2000 file system support
[    1.566505] io scheduler mq-deadline registered
[    1.569734] io scheduler kyber registered
[    1.573894] layerscape-pcie-gen4 3600000.pcie: host bridge /soc/pcie@360=
0000 ranges:
[    1.580351] layerscape-pcie-gen4 3600000.pcie:      MEM 0x9040000000..0x=
907fffffff -> 0x0040000000
[    1.588204] layerscape-pcie-gen4 3600000.pcie: PCI host bridge to bus 00=
00:00
[    1.594036] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.598216] pci_bus 0000:00: root bus resource [mem 0x9040000000-0x907ff=
fffff] (bus address [0x40000000-0x7fffffff])
[    1.607459] pci 0000:00:00.0: [1957:8d90] type 01 class 0x060400
[    1.612198] pci 0000:00:00.0: enabling Extended Tags
[    1.615912] pci 0000:00:00.0: supports D1 D2
[    1.618869] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.624897] pci 0000:01:00.0: [1cc1:8201] type 00 class 0x010802
[    1.629666] pci 0000:01:00.0: reg 0x10: [mem 0x9040000000-0x9040003fff 6=
4bit]
[    1.646977] pci 0000:00:00.0: up support 3 enabled 0
[    1.650628] pci 0000:00:00.0: dn support 2 enabled 0
[    1.654743] pci 0000:00:00.0: BAR 8: assigned [mem 0x9040000000-0x90400f=
ffff]
[    1.660577] pci 0000:01:00.0: BAR 0: assigned [mem 0x9040000000-0x904000=
3fff 64bit]
[    1.666945] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.670859] pci 0000:00:00.0:   bridge window [mem 0x9040000000-0x90400f=
ffff]
[    1.676698] pci 0000:00:00.0: Max Payload Size set to  256/ 256 (was  12=
8), Max Read Rq  256
[    1.683858] pci 0000:01:00.0: Max Payload Size set to  256/ 256 (was  12=
8), Max Read Rq  256
[    1.691047] pcieport 0000:00:00.0: PCIe capabilities: 0x13
[    1.695230] pcieport 0000:00:00.0: init_service_irqs: -19
[    1.699429] layerscape-pcie-gen4 3800000.pcie: host bridge /soc/pcie@380=
0000 ranges:
[    1.705877] layerscape-pcie-gen4 3800000.pcie:      MEM 0xa040000000..0x=
a07fffffff -> 0x0040000000
[    1.713713] layerscape-pcie-gen4 3800000.pcie: PCI host bridge to bus 00=
01:00
[    1.719544] pci_bus 0001:00: root bus resource [bus 00-ff]
[    1.723724] pci_bus 0001:00: root bus resource [mem 0xa040000000-0xa07ff=
fffff] (bus address [0x40000000-0x7fffffff])
[    1.732950] pci 0001:00:00.0: [1957:8d90] type 01 class 0x060400
[    1.737694] pci 0001:00:00.0: enabling Extended Tags
[    1.741407] pci 0001:00:00.0: supports D1 D2
[    1.744371] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.750511] pci 0001:01:00.0: [15b3:6750] type 00 class 0x020000
[    1.755600] pci 0001:01:00.0: reg 0x10: [mem 0xa040000000-0xa0400fffff 6=
4bit]
[    1.761632] pci 0001:01:00.0: reg 0x18: [mem 0xa040800000-0xa040ffffff 6=
4bit pref]
[    1.768286] pci 0001:01:00.0: reg 0x30: [mem 0xa041000000-0xa0410fffff p=
ref]
[    1.787013] pci 0001:00:00.0: up support 3 enabled 0
[    1.790665] pci 0001:00:00.0: dn support 1 enabled 0
[    1.794787] pci 0001:00:00.0: BAR 9: assigned [mem 0xa040000000-0xa0407f=
ffff 64bit pref]
[    1.801572] pci 0001:00:00.0: BAR 8: assigned [mem 0xa040800000-0xa0409f=
ffff]
[    1.807404] pci 0001:01:00.0: BAR 2: assigned [mem 0xa040000000-0xa0407f=
ffff 64bit pref]
[    1.814316] pci 0001:01:00.0: BAR 0: assigned [mem 0xa040800000-0xa0408f=
ffff 64bit]
[    1.820793] pci 0001:01:00.0: BAR 6: assigned [mem 0xa040900000-0xa0409f=
ffff pref]
[    1.827056] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    1.830977] pci 0001:00:00.0:   bridge window [mem 0xa040800000-0xa0409f=
ffff]
[    1.836806] pci 0001:00:00.0:   bridge window [mem 0xa040000000-0xa0407f=
ffff 64bit pref]
[    1.843601] pci 0001:00:00.0: Max Payload Size set to  256/ 256 (was  12=
8), Max Read Rq  256
[    1.850903] pci 0001:01:00.0: Max Payload Size set to  256/ 256 (was  12=
8), Max Read Rq  256
[    1.858079] pcieport 0001:00:00.0: PCIe capabilities: 0x13
[    1.862260] pcieport 0001:00:00.0: init_service_irqs: -19
[    1.867322] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.874084] arm-smmu 5000000.iommu: probing hardware configuration...
[    1.879225] arm-smmu 5000000.iommu: SMMUv2 with:
[    1.882529] arm-smmu 5000000.iommu: 	stage 1 translation
[    1.886534] arm-smmu 5000000.iommu: 	stage 2 translation
[    1.890539] arm-smmu 5000000.iommu: 	nested translation
[    1.894457] arm-smmu 5000000.iommu: 	coherent table walk
[    1.898461] arm-smmu 5000000.iommu: 	(IDR0.CTTW overridden by FW configu=
ration)
[    1.904464] arm-smmu 5000000.iommu: 	stream matching with 128 register g=
roups
[    1.910294] arm-smmu 5000000.iommu: 	64 context banks (0 stage-2 only)
[    1.915519] arm-smmu 5000000.iommu: 	Supported page sizes: 0x61311000
[    1.920653] arm-smmu 5000000.iommu: 	Stage-1: 48-bit VA -> 48-bit IPA
[    1.925786] arm-smmu 5000000.iommu: 	Stage-2: 48-bit IPA -> 48-bit PA
[    1.946137] loop: module loaded
[    1.948871] nvme nvme0: pci function 0000:01:00.0
[    1.952710] ahci-qoriq 3200000.sata: 3200000.sata supply ahci not found,=
 using dummy regulator
[    1.960072] ahci-qoriq 3200000.sata: 3200000.sata supply phy not found, =
using dummy regulator
[    1.967335] ahci-qoriq 3200000.sata: 3200000.sata supply target not foun=
d, using dummy regulator
[    1.974957] ahci-qoriq 3200000.sata: AHCI 0001.0301 32 slots 1 ports 6 G=
bps 0x1 impl platform mode
[    1.982613] ahci-qoriq 3200000.sata: flags: 64bit ncq sntf pm clo only p=
mp fbs pio slum part ccc sds apst =

[    1.991486] scsi host0: ahci-qoriq
[    1.993859] ata1: SATA max UDMA/133 mmio [mem 0x03200000-0x0320ffff] por=
t 0x100 irq 24
[    2.000561] ahci-qoriq 3210000.sata: 3210000.sata supply ahci not found,=
 using dummy regulator
[    2.007916] ahci-qoriq 3210000.sata: 3210000.sata supply phy not found, =
using dummy regulator
[    2.015194] ahci-qoriq 3210000.sata: 3210000.sata supply target not foun=
d, using dummy regulator
[    2.022788] ahci-qoriq 3210000.sata: AHCI 0001.0301 32 slots 1 ports 6 G=
bps 0x1 impl platform mode
[    2.030443] ahci-qoriq 3210000.sata: flags: 64bit ncq sntf pm clo only p=
mp fbs pio slum part ccc sds apst =

[    2.039256] scsi host1: ahci-qoriq
[    2.041507] ata2: SATA max UDMA/133 mmio [mem 0x03210000-0x0321ffff] por=
t 0x100 irq 25
[    2.048196] ahci-qoriq 3220000.sata: 3220000.sata supply ahci not found,=
 using dummy regulator
[    2.055550] ahci-qoriq 3220000.sata: 3220000.sata supply phy not found, =
using dummy regulator
[    2.062811] ahci-qoriq 3220000.sata: 3220000.sata supply target not foun=
d, using dummy regulator
[    2.070378] ahci-qoriq 3220000.sata: AHCI 0001.0301 32 slots 1 ports 6 G=
bps 0x1 impl platform mode
[    2.078032] ahci-qoriq 3220000.sata: flags: 64bit ncq sntf pm clo only p=
mp fbs pio slum part ccc sds apst =

[    2.084600] nvme nvme0: 15/0/0 default/read/poll queues
[    2.086837] scsi host2: ahci-qoriq
[    2.092574] ata3: SATA max UDMA/133 mmio [mem 0x03220000-0x0322ffff] por=
t 0x100 irq 26
[    2.092925]  nvme0n1: p1 p2
[    2.099262] ahci-qoriq 3230000.sata: 3230000.sata supply ahci not found,=
 using dummy regulator
[    2.108028] ahci-qoriq 3230000.sata: 3230000.sata supply phy not found, =
using dummy regulator
[    2.115290] ahci-qoriq 3230000.sata: 3230000.sata supply target not foun=
d, using dummy regulator
[    2.122864] ahci-qoriq 3230000.sata: AHCI 0001.0301 32 slots 1 ports 6 G=
bps 0x1 impl platform mode
[    2.130518] ahci-qoriq 3230000.sata: flags: 64bit ncq sntf pm clo only p=
mp fbs pio slum part ccc sds apst =

[    2.139348] scsi host3: ahci-qoriq
[    2.141598] ata4: SATA max UDMA/133 mmio [mem 0x03230000-0x0323ffff] por=
t 0x100 irq 27
[    2.149539] libphy: Fixed MDIO Bus: probed
[    2.152802] libphy: Freescale XGMAC MDIO Bus: probed
[    2.156799] Qualcomm Atheros AR8035 8b96000:01: probe: irq=3D-1
[    2.161245] Qualcomm Atheros AR8035 8b96000:01: probe: irq=3D-1
[    2.165963] libphy: Freescale XGMAC MDIO Bus: probed
[    2.170081] dwc3 3100000.usb: Failed to get clk 'ref': -2
[    2.174468] dwc3 3110000.usb: Failed to get clk 'ref': -2
[    2.179050] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.184274] ehci-platform: EHCI generic platform driver
[    2.188257] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.193140] ohci-platform: OHCI generic platform driver
[    2.197268] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.201470] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned b=
us number 1
[    2.207946] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version =
0x100 quirks 0x0000000002010010
[    2.216064] xhci-hcd xhci-hcd.0.auto: irq 22, io mem 0x03100000
[    2.221416] hub 1-0:1.0: USB hub found
[    2.223894] hub 1-0:1.0: 1 port detected
[    2.226762] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.230951] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned b=
us number 2
[    2.237305] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    2.242572] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.249744] hub 2-0:1.0: USB hub found
[    2.252209] hub 2-0:1.0: 1 port detected
[    2.255118] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    2.259309] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 3
[    2.265760] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f66d hci version =
0x100 quirks 0x0000000002010010
[    2.273872] xhci-hcd xhci-hcd.1.auto: irq 23, io mem 0x03110000
[    2.279084] hub 3-0:1.0: USB hub found
[    2.281538] hub 3-0:1.0: 1 port detected
[    2.284380] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    2.288571] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 4
[    2.294930] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    2.300190] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.307363] hub 4-0:1.0: USB hub found
[    2.309817] hub 4-0:1.0: 1 port detected
[    2.312750] usbcore: registered new interface driver usb-storage
[    2.317173] ata1: SATA link down (SStatus 0 SControl 300)
[    2.317696] mousedev: PS/2 mouse device common for all mice
[    2.331955] rtc-pcf2127-i2c 2-0051: registered as rtc0
[    2.335876] i2c /dev entries driver
[    2.339327] i2c i2c-0: Added multiplexed i2c bus 3
[    2.343067] i2c i2c-0: Added multiplexed i2c bus 4
[    2.346783] i2c i2c-0: Added multiplexed i2c bus 5
[    2.350507] i2c i2c-0: Added multiplexed i2c bus 6
[    2.354164] i2c i2c-0: Added multiplexed i2c bus 7
[    2.357821] i2c i2c-0: Added multiplexed i2c bus 8
[    2.361159] ata2: SATA link down (SStatus 0 SControl 300)
[    2.361480] i2c i2c-0: Added multiplexed i2c bus 9
[    2.369047] i2c i2c-0: Added multiplexed i2c bus 10
[    2.372627] pca954x 0-0077: registered 8 multiplexed busses for I2C mux =
pca9547
[    2.378783] IR NEC protocol handler initialized
[    2.382010] IR RC5(x/sz) protocol handler initialized
[    2.385755] IR RC6 protocol handler initialized
[    2.388977] IR JVC protocol handler initialized
[    2.392200] IR Sony protocol handler initialized
[    2.395513] IR SANYO protocol handler initialized
[    2.398903] IR Sharp protocol handler initialized
[    2.402300] IR MCE Keyboard/mouse protocol handler initialized
[    2.406827] IR XMP protocol handler initialized
[    2.413367] amc6821 4-0018: Error reading configuration register, aborti=
ng.
[    2.417180] ata3: SATA link down (SStatus 0 SControl 300)
[    2.419034] amc6821: probe of 4-0018 failed with error -5
[    2.427436] sdhci: Secure Digital Host Controller Interface driver
[    2.432314] sdhci: Copyright(c) Pierre Ossman
[    2.435384] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.461157] ata4: SATA link down (SStatus 0 SControl 300)
[    2.465487] mmc0: SDHCI controller on 2140000.esdhc [2140000.esdhc] usin=
g ADMA 64-bit
[    2.494954] mmc1: SDHCI controller on 2150000.esdhc [2150000.esdhc] usin=
g ADMA 64-bit
[    2.502071] ledtrig-cpu: registered to indicate activity on CPUs
[    2.507175] caam 8000000.crypto: device ID =3D 0x0a1a020000000000 (Era 1=
0)
[    2.508538] mmc0: new high speed SDHC card at address aaaa
[    2.512572] caam 8000000.crypto: job rings =3D 3, qi =3D 1
[    2.521006] mmcblk0: mmc0:aaaa SU04G 3.69 GiB (ro)
[    2.525840] caam algorithms registered in /proc/crypto
[    2.532365] caam 8000000.crypto: caam pkc algorithms registered in /proc=
/crypto
[    2.539400] caam_jr 8010000.jr: registering rng-caam
[    2.543736] usbcore: registered new interface driver usbhid
[    2.548007] usbhid: USB HID core driver
[    2.551148] NET: Registered protocol family 10
[    2.554963] Segment Routing with IPv6
[    2.557343] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.562313] NET: Registered protocol family 17
[    2.565629] 9pnet: Installing 9P2000 support
[    2.568641] Key type dns_resolver registered
[    2.571820] registered taskstats version 1
[    2.578646] fsl_mc_dprc dprc.1: Adding to iommu group 0
[    2.584473] mmc1: new HS400 MMC card at address 0001
[    2.592566] mmcblk1: mmc1:0001 DF4064 58.2 GiB =

[    2.595945] mmcblk1boot0: mmc1:0001 DF4064 partition 1 4.00 MiB
[    2.600717] mmcblk1boot1: mmc1:0001 DF4064 partition 2 4.00 MiB
[    2.605471] mmcblk1rpmb: mmc1:0001 DF4064 partition 3 4.00 MiB, chardev =
(246:0)
[    2.612749]  mmcblk1: p1 p2
[    2.622945] usb 3-1: new high-speed USB device number 2 using xhci-hcd
[    2.642000] fsl_dpaa2_eth dpni.0: Adding to iommu group 0
[    2.646254] fsl_mc_dprc dprc.1: No more resources of type dpmcp left
[    2.651688] fsl_mc_allocator dpbp.1: Adding to iommu group 0
[    2.656161] fsl_mc_allocator dpbp.0: Adding to iommu group 0
[    2.662117] fsl_mc_allocator dpmcp.35: Adding to iommu group 0
[    2.667765] fsl_mc_allocator dpmcp.34: Adding to iommu group 0
[    2.673422] fsl_mc_allocator dpmcp.33: Adding to iommu group 0
[    2.679071] fsl_mc_allocator dpmcp.32: Adding to iommu group 0
[    2.684267] hub 3-1:1.0: USB hub found
[    2.684727] fsl_mc_allocator dpmcp.31: Adding to iommu group 0
[    2.686736] hub 3-1:1.0: 4 ports detected
[    2.692343] fsl_mc_allocator dpmcp.30: Adding to iommu group 0
[    2.699627] fsl_mc_allocator dpmcp.29: Adding to iommu group 0
[    2.705265] fsl_mc_allocator dpmcp.28: Adding to iommu group 0
[    2.710952] fsl_mc_allocator dpmcp.27: Adding to iommu group 0
[    2.716596] fsl_mc_allocator dpmcp.26: Adding to iommu group 0
[    2.722243] fsl_mc_allocator dpmcp.25: Adding to iommu group 0
[    2.727897] fsl_mc_allocator dpmcp.24: Adding to iommu group 0
[    2.733550] fsl_mc_allocator dpmcp.23: Adding to iommu group 0
[    2.739198] fsl_mc_allocator dpmcp.22: Adding to iommu group 0
[    2.744853] fsl_mc_allocator dpmcp.21: Adding to iommu group 0
[    2.750495] fsl_mc_allocator dpmcp.20: Adding to iommu group 0
[    2.756161] fsl_mc_allocator dpmcp.19: Adding to iommu group 0
[    2.761803] fsl_mc_allocator dpmcp.18: Adding to iommu group 0
[    2.767473] fsl_mc_allocator dpmcp.17: Adding to iommu group 0
[    2.773117] fsl_mc_allocator dpmcp.16: Adding to iommu group 0
[    2.778768] fsl_mc_allocator dpmcp.15: Adding to iommu group 0
[    2.782959] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using xhci=
-hcd
[    2.784414] fsl_mc_allocator dpmcp.14: Adding to iommu group 0
[    2.794669] fsl_mc_allocator dpmcp.13: Adding to iommu group 0
[    2.800309] fsl_mc_allocator dpmcp.12: Adding to iommu group 0
[    2.805969] fsl_mc_allocator dpmcp.11: Adding to iommu group 0
[    2.811625] fsl_mc_allocator dpmcp.10: Adding to iommu group 0
[    2.817271] fsl_mc_allocator dpmcp.9: Adding to iommu group 0
[    2.822845] fsl_mc_allocator dpmcp.8: Adding to iommu group 0
[    2.828243] hub 4-1:1.0: USB hub found
[    2.828420] fsl_mc_allocator dpmcp.7: Adding to iommu group 0
[    2.830710] hub 4-1:1.0: 4 ports detected
[    2.836276] fsl_mc_allocator dpmcp.6: Adding to iommu group 0
[    2.843415] fsl_mc_allocator dpmcp.5: Adding to iommu group 0
[    2.848975] fsl_mc_allocator dpmcp.4: Adding to iommu group 0
[    2.851038] random: fast init done
[    2.854534] fsl_mc_allocator dpmcp.3: Adding to iommu group 0
[    2.861060] fsl_mc_allocator dpmcp.2: Adding to iommu group 0
[    2.866622] fsl_mc_allocator dpmcp.1: Adding to iommu group 0
[    2.874308] fsl_mc_dpio dpio.15: Adding to iommu group 0
[    2.882022] fsl_mc_dpio dpio.15: probed
[    2.888261] fsl_mc_dpio dpio.14: Adding to iommu group 0
[    2.895912] fsl_mc_dpio dpio.14: probed
[    2.902061] fsl_mc_dpio dpio.13: Adding to iommu group 0
[    2.909710] fsl_mc_dpio dpio.13: probed
[    2.915939] fsl_mc_dpio dpio.12: Adding to iommu group 0
[    2.923591] fsl_mc_dpio dpio.12: probed
[    2.929752] fsl_mc_dpio dpio.11: Adding to iommu group 0
[    2.937396] fsl_mc_dpio dpio.11: probed
[    2.943628] fsl_mc_dpio dpio.10: Adding to iommu group 0
[    2.951283] fsl_mc_dpio dpio.10: probed
[    2.957446] fsl_mc_dpio dpio.9: Adding to iommu group 0
[    2.965012] fsl_mc_dpio dpio.9: probed
[    2.971167] fsl_mc_dpio dpio.8: Adding to iommu group 0
[    2.978776] fsl_mc_dpio dpio.8: probed
[    2.984923] fsl_mc_dpio dpio.7: Adding to iommu group 0
[    2.992537] fsl_mc_dpio dpio.7: probed
[    2.998684] fsl_mc_dpio dpio.6: Adding to iommu group 0
[    3.006299] fsl_mc_dpio dpio.6: probed
[    3.012440] fsl_mc_dpio dpio.5: Adding to iommu group 0
[    3.020064] fsl_mc_dpio dpio.5: probed
[    3.026190] fsl_mc_dpio dpio.4: Adding to iommu group 0
[    3.033754] fsl_mc_dpio dpio.4: probed
[    3.038937] usb 3-1.3: new high-speed USB device number 3 using xhci-hcd
[    3.039844] fsl_mc_dpio dpio.3: Adding to iommu group 0
[    3.051890] fsl_mc_dpio dpio.3: probed
[    3.058009] fsl_mc_dpio dpio.2: Adding to iommu group 0
[    3.065609] fsl_mc_dpio dpio.2: probed
[    3.071763] fsl_mc_dpio dpio.1: Adding to iommu group 0
[    3.079384] fsl_mc_dpio dpio.1: probed
[    3.085521] fsl_mc_dpio dpio.0: Adding to iommu group 0
[    3.093136] fsl_mc_dpio dpio.0: probed
[    3.096201] fsl_mc_allocator dpcon.31: Adding to iommu group 0
[    3.100196] hub 3-1.3:1.0: USB hub found
[    3.100860] fsl_mc_allocator dpcon.30: Adding to iommu group 0
[    3.103374] hub 3-1.3:1.0: 4 ports detected
[    3.107983] fsl_mc_allocator dpcon.29: Adding to iommu group 0
[    3.115381] fsl_mc_allocator dpcon.28: Adding to iommu group 0
[    3.120030] fsl_mc_allocator dpcon.27: Adding to iommu group 0
[    3.124682] fsl_mc_allocator dpcon.26: Adding to iommu group 0
[    3.129333] fsl_mc_allocator dpcon.25: Adding to iommu group 0
[    3.133987] fsl_mc_allocator dpcon.24: Adding to iommu group 0
[    3.138642] fsl_mc_allocator dpcon.23: Adding to iommu group 0
[    3.143294] fsl_mc_allocator dpcon.22: Adding to iommu group 0
[    3.147946] fsl_mc_allocator dpcon.21: Adding to iommu group 0
[    3.152597] fsl_mc_allocator dpcon.20: Adding to iommu group 0
[    3.157250] fsl_mc_allocator dpcon.19: Adding to iommu group 0
[    3.161903] fsl_mc_allocator dpcon.18: Adding to iommu group 0
[    3.166559] fsl_mc_allocator dpcon.17: Adding to iommu group 0
[    3.171217] fsl_mc_allocator dpcon.16: Adding to iommu group 0
[    3.175871] fsl_mc_allocator dpcon.15: Adding to iommu group 0
[    3.180533] fsl_mc_allocator dpcon.14: Adding to iommu group 0
[    3.185188] fsl_mc_allocator dpcon.13: Adding to iommu group 0
[    3.189844] fsl_mc_allocator dpcon.12: Adding to iommu group 0
[    3.194499] fsl_mc_allocator dpcon.11: Adding to iommu group 0
[    3.199153] fsl_mc_allocator dpcon.10: Adding to iommu group 0
[    3.203810] fsl_mc_allocator dpcon.9: Adding to iommu group 0
[    3.208385] fsl_mc_allocator dpcon.8: Adding to iommu group 0
[    3.212956] fsl_mc_allocator dpcon.7: Adding to iommu group 0
[    3.217526] fsl_mc_allocator dpcon.6: Adding to iommu group 0
[    3.222096] fsl_mc_allocator dpcon.5: Adding to iommu group 0
[    3.226667] fsl_mc_allocator dpcon.4: Adding to iommu group 0
[    3.231237] fsl_mc_allocator dpcon.3: Adding to iommu group 0
[    3.235812] fsl_mc_allocator dpcon.2: Adding to iommu group 0
[    3.240383] fsl_mc_allocator dpcon.1: Adding to iommu group 0
[    3.244955] fsl_mc_allocator dpcon.0: Adding to iommu group 0
[    3.252565] fsl_mc_dprc dprc.1: DPRC device bound to driver
[    3.257032] libphy: SFP I2C Bus: probed
[    3.259658] sfp sfp-0: Host maximum power 2.0W
[    3.262929] sfp sfp-0: No tx_disable pin: SFP modules will always be emi=
tting.
[    3.269061] libphy: SFP I2C Bus: probed
[    3.271642] sfp sfp-1: Host maximum power 2.0W
[    3.274884] sfp sfp-1: No tx_disable pin: SFP modules will always be emi=
tting.
[    3.280979] libphy: SFP I2C Bus: probed
[    3.283559] sfp sfp-2: Host maximum power 2.0W
[    3.286819] sfp sfp-2: No tx_disable pin: SFP modules will always be emi=
tting.
[    3.292948] libphy: SFP I2C Bus: probed
[    3.295529] sfp sfp-3: Host maximum power 2.0W
[    3.298768] sfp sfp-3: No tx_disable pin: SFP modules will always be emi=
tting.
[    3.456609] fsl_dpaa2_eth dpni.0 (unnamed net_device) (uninitialized): P=
HY [8b96000:01] driver [Qualcomm Atheros AR8035] (irq=3DPOLL)
[    3.467153] fsl_dpaa2_eth dpni.0 (unnamed net_device) (uninitialized): p=
hy: setting supported 000,00000200,000062ea advertising 000,00000200,000062=
ea
[    3.468341] fsl_dpaa2_eth dpni.0: Probed interface eth0
[    3.472672] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    3.479780] rtc-pcf2127-i2c 2-0051: setting system clock to 2020-02-28T0=
9:56:18 UTC (1582883778)
[    3.490224] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mo=
de. Opts: (null)
[    3.497082] VFS: Mounted root (ext4 filesystem) readonly on device 259:2.
[    3.503193] devtmpfs: mounted
[    3.505079] Freeing unused kernel memory: 960K
[    3.534993] Run /sbin/init as init process

When asking for more network interfaces, more "Adding to iommu group"
messages get spat out:

[  446.040825] fsl_dpaa2_eth dpni.1: Adding to iommu group 0
[  446.201254] libphy: Freescale XGMAC MDIO Bus: probed
[  446.206552] fsl_dpaa2_eth dpni.1: Probed interface eth1
[  446.210715] fsl_mc_allocator dpbp.2: Adding to iommu group 0
[  446.216838] fsl_mc_allocator dpmcp.36: Adding to iommu group 0
[  446.224808] fsl_mc_allocator dpcon.47: Adding to iommu group 0
[  446.229935] fsl_mc_allocator dpcon.46: Adding to iommu group 0
[  446.234685] fsl_mc_allocator dpcon.45: Adding to iommu group 0
[  446.239431] fsl_mc_allocator dpcon.44: Adding to iommu group 0
[  446.244179] fsl_mc_allocator dpcon.43: Adding to iommu group 0
[  446.251725] fsl_mc_allocator dpcon.42: Adding to iommu group 0
[  446.258952] fsl_mc_allocator dpcon.41: Adding to iommu group 0
[  446.263666] fsl_mc_allocator dpcon.40: Adding to iommu group 0
[  446.268377] fsl_mc_allocator dpcon.39: Adding to iommu group 0
[  446.273086] fsl_mc_allocator dpcon.38: Adding to iommu group 0
[  446.277814] fsl_mc_allocator dpcon.37: Adding to iommu group 0
[  446.282517] fsl_mc_allocator dpcon.36: Adding to iommu group 0
[  446.287228] fsl_mc_allocator dpcon.35: Adding to iommu group 0
[  446.291935] fsl_mc_allocator dpcon.34: Adding to iommu group 0
[  446.296641] fsl_mc_allocator dpcon.33: Adding to iommu group 0
[  446.301354] fsl_mc_allocator dpcon.32: Adding to iommu group 0
[  446.893939] fsl_dpaa2_eth dpni.2: Adding to iommu group 0
[  447.052868] libphy: Freescale XGMAC MDIO Bus: probed
[  447.058223] fsl_dpaa2_eth dpni.2: Probed interface eth2
[  447.062425] fsl_mc_allocator dpbp.3: Adding to iommu group 0
[  447.068813] fsl_mc_allocator dpmcp.37: Adding to iommu group 0
[  447.074280] fsl_mc_allocator dpcon.63: Adding to iommu group 0
[  447.078995] fsl_mc_allocator dpcon.62: Adding to iommu group 0
[  447.088690] fsl_mc_allocator dpcon.61: Adding to iommu group 0
[  447.093639] fsl_mc_allocator dpcon.60: Adding to iommu group 0
[  447.098369] fsl_mc_allocator dpcon.59: Adding to iommu group 0
[  447.103089] fsl_mc_allocator dpcon.58: Adding to iommu group 0
[  447.107811] fsl_mc_allocator dpcon.57: Adding to iommu group 0
[  447.112525] fsl_mc_allocator dpcon.56: Adding to iommu group 0
[  447.117244] fsl_mc_allocator dpcon.55: Adding to iommu group 0
[  447.121962] fsl_mc_allocator dpcon.54: Adding to iommu group 0
[  447.126680] fsl_mc_allocator dpcon.53: Adding to iommu group 0
[  447.131392] fsl_mc_allocator dpcon.52: Adding to iommu group 0
[  447.136107] fsl_mc_allocator dpcon.51: Adding to iommu group 0
[  447.140820] fsl_mc_allocator dpcon.50: Adding to iommu group 0
[  447.145535] fsl_mc_allocator dpcon.49: Adding to iommu group 0
[  447.150249] fsl_mc_allocator dpcon.48: Adding to iommu group 0
[  447.710694] fsl_dpaa2_eth dpni.3: Adding to iommu group 0
[  447.888120] libphy: Freescale XGMAC MDIO Bus: probed
[  447.893479] fsl_dpaa2_eth dpni.3: Probed interface eth3
[  447.897740] fsl_mc_allocator dpbp.4: Adding to iommu group 0
[  447.904488] fsl_mc_allocator dpmcp.38: Adding to iommu group 0
[  447.909994] fsl_mc_allocator dpcon.79: Adding to iommu group 0
[  447.914717] fsl_mc_allocator dpcon.78: Adding to iommu group 0
[  447.919852] fsl_mc_allocator dpcon.77: Adding to iommu group 0
[  447.924720] fsl_mc_allocator dpcon.76: Adding to iommu group 0
[  447.931979] fsl_mc_allocator dpcon.75: Adding to iommu group 0
[  447.939172] fsl_mc_allocator dpcon.74: Adding to iommu group 0
[  447.943886] fsl_mc_allocator dpcon.73: Adding to iommu group 0
[  447.948604] fsl_mc_allocator dpcon.72: Adding to iommu group 0
[  447.953319] fsl_mc_allocator dpcon.71: Adding to iommu group 0
[  447.958035] fsl_mc_allocator dpcon.70: Adding to iommu group 0
[  447.965445] fsl_mc_allocator dpcon.69: Adding to iommu group 0
[  447.972653] fsl_mc_allocator dpcon.68: Adding to iommu group 0
[  447.977376] fsl_mc_allocator dpcon.67: Adding to iommu group 0
[  447.982097] fsl_mc_allocator dpcon.66: Adding to iommu group 0
[  447.986816] fsl_mc_allocator dpcon.65: Adding to iommu group 0
[  447.991532] fsl_mc_allocator dpcon.64: Adding to iommu group 0
[  448.737198] fsl_dpaa2_eth dpni.4: Adding to iommu group 0
[  448.894480] libphy: Freescale XGMAC MDIO Bus: probed
[  448.899785] fsl_dpaa2_eth dpni.4: Probed interface eth4
[  448.904077] fsl_mc_allocator dpbp.5: Adding to iommu group 0
[  448.909817] fsl_mc_allocator dpmcp.39: Adding to iommu group 0
[  448.915340] fsl_mc_allocator dpcon.95: Adding to iommu group 0
[  448.920068] fsl_mc_allocator dpcon.94: Adding to iommu group 0
[  448.924789] fsl_mc_allocator dpcon.93: Adding to iommu group 0
[  448.929689] fsl_mc_allocator dpcon.92: Adding to iommu group 0
[  448.934436] fsl_mc_allocator dpcon.91: Adding to iommu group 0
[  448.939159] fsl_mc_allocator dpcon.90: Adding to iommu group 0
[  448.943882] fsl_mc_allocator dpcon.89: Adding to iommu group 0
[  448.948607] fsl_mc_allocator dpcon.88: Adding to iommu group 0
[  448.953327] fsl_mc_allocator dpcon.87: Adding to iommu group 0
[  448.958050] fsl_mc_allocator dpcon.86: Adding to iommu group 0
[  448.962771] fsl_mc_allocator dpcon.85: Adding to iommu group 0
[  448.967499] fsl_mc_allocator dpcon.84: Adding to iommu group 0
[  448.972219] fsl_mc_allocator dpcon.83: Adding to iommu group 0
[  448.976941] fsl_mc_allocator dpcon.82: Adding to iommu group 0
[  448.981669] fsl_mc_allocator dpcon.81: Adding to iommu group 0
[  448.986391] fsl_mc_allocator dpcon.80: Adding to iommu group 0

# dmesg |grep 'Adding to iommu' | wc -l
164
# dmesg |grep -v 'Adding to iommu' | wc -l
551

So, 23% of the kernel messages on this platform are "Adding to iommu",
which is excessive.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
