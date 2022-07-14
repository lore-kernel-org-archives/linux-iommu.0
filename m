Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8DB2F25
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 09:37:23 +0000 (UTC)
Received: by mail-il1-f198.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso833728ilk.3
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=WFr8N/EOSmpJftgydqWTgWKBCIxK/qqg2SGca5b7/a0=;
        b=PSU7UJqoslJyX9mMERm0v362q9W/ccrdzjbjuE6MRM1amDwUlzKFDC4S2CIoaxcbF/
         e38xi/QK9TgLxQsM+qlxtgutlOK4tvQ+06Tg0dikHDALb1XljQKVO9oqv4zWGAoal37y
         XyK0fNlNiZEShI3kRDUkbDFbNfQm2vn2y36d8h01H1YPqpJwJ4arVCh3Bx+N5/kCYLRo
         FmuQPwGdi9NZz+6u2aE9QCbBwFziRuNbQI9ldRg/0PFPh2ndtCIpVxaKEIsk8pWRhWyU
         34CuC581hCnHjxRmUQpgsoiZbuDt9ahmMFQbXYG/8HiJhBhDHjdK8fBRrGiAgO4YmV9E
         6Tpw==
X-Gm-Message-State: AJIora8riD8cpZvvbohup1QvnBdk3g5tGTQgv7uEJmvqEZE+2f4ihjaF
	U/TJ67axSRldXv5FUZcFo3A3IE9HEKuySFdUpx2OhQwDRdM1
X-Google-Smtp-Source: AGRyM1sxKJjXTj4UWFLpmqINTljIveX51rI2INVvyAcfGFllt4JljMPZ63V8JFmC4qfytTKGfBRdfnZRa/QQCTAJM5EWQJDzPCdw
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:419a:b0:341:3eac:e467 with SMTP id
 az26-20020a056638419a00b003413eace467mr936227jab.101.1657791442807; Thu, 14
 Jul 2022 02:37:22 -0700 (PDT)
Date: Thu, 14 Jul 2022 02:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f74bf05e3c0a6f0@google.com>
Subject: [syzbot] linux-next boot error: kernel panic: swiotlb_init_remap:
 nslabs = NUM too small
From: syzbot <syzbot+99f6c2141b62e707578c@syzkaller.appspotmail.com>
To: hch@infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    4662b7adea50 Add linux-next specific files for 20220713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17a1c5c8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D91e2c45190556e7=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D99f6c2141b62e7075=
78c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils=
 for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+99f6c2141b62e707578c@syzkaller.appspotmail.com

NODE_DATA(0) allocated [mem 0x13fffa000-0x13fffffff]
NODE_DATA(1) allocated [mem 0x23fff7000-0x23fffcfff]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000023fffffff]
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
  node   0: [mem 0x0000000100000000-0x000000013fffffff]
  node   1: [mem 0x0000000140000000-0x000000023fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 3 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 69 pages/cpu s243848 r8192 d30584 u1048576
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Fallback order for Node 0: 0 1=20
Fallback order for Node 1: 1 0=20
Built 2 zonelists, mobility grouping on.  Total pages: 2064125
Policy zone: Normal
Kernel command line: earlyprintk=3Dserial net.ifnames=3D0 sysctl.kernel.hun=
g_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-conntrack-ftp.ports=3D2000=
0 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 nf-conntra=
ck-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0 =
rcupdate.rcu_expedited=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hu=
gepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysc=
tl.max_rcu_stall_to_panic=3D1 msr.allow_writes=3Doff root=3D/dev/sda consol=
e=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 spec_store=
_bypass_disable=3Dprctl nopcid vivid.n_devs=3D16 vivid.multiplanar=3D1,2,1,=
2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D16 rose.rose_ndevs=3D16 dummy_h=
cd.num=3D8 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.wat=
chdog_thresh=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 pan=
ic_on_warn=3D1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev/sda1 console=3DttyS0
Unknown kernel command line parameters "spec_store_bypass_disable=3Dprctl B=
OOT_IMAGE=3D/boot/bzImage", will be passed to user space.
mem auto-init: stack:off, heap alloc:on, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Kernel panic - not syncing: swiotlb_init_remap: nslabs =3D 0 too small
CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc6-next-20220713-syzkaller =
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2c8/0x627 kernel/panic.c:274
 swiotlb_init_remap+0x60/0x7e kernel/dma/swiotlb.c:306
 mem_init+0x18/0x351 arch/x86/mm/init_64.c:1332
 mm_init+0xa1/0xc9 init/main.c:843
 start_kernel+0x18e/0x494 init/main.c:990
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
