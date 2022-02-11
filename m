Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BF7C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 02:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E0DC41625;
	Fri, 11 Feb 2022 02:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQOQPCCVmEW0; Fri, 11 Feb 2022 02:45:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5911441615;
	Fri, 11 Feb 2022 02:45:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31288C0011;
	Fri, 11 Feb 2022 02:45:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3227AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 02:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 105D54010E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 02:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xI1MMRPbYsTH for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 02:45:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF8AA400FB
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 02:45:51 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id y18so3513382plb.11
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=onGwi/KakZ5VdGLGbEsOrZyDEkivEQUrx0yJjIzNNyw=;
 b=YL57bAm0Z5M5/1vi6dzr+1B0OXjqWB/Dc118Xhuxgw2bpRRYaZUyoan0EfGtZw6O8p
 xbZ+YUfIGgFtNxer5NDwTPoot0XyaPtFj/G/HWlL1xlcVpvPaOKmL4/iYrIdROMMurGy
 mi4gSB+vL6vz3QYEOMtWjdFJ0cc2kqxpWhui+Yh2YQLtXfVyOr8qX/4yUQ8xDD/4v7Ll
 1BZKchKVvno2r+lwxeoYnkjGnetuwMFQyhuOCOGqvRHqhq+Sy6q0SCS6v8R7fgz+eSbv
 DATErpijgQ+y5bbEgBzgnWhrturB8HTjgl+hIWrt6hl3PV2IHqSURkzI4H7NHB4FUFt3
 vmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=onGwi/KakZ5VdGLGbEsOrZyDEkivEQUrx0yJjIzNNyw=;
 b=XiJuVdEZe5bE1mxZ4BMX2tDsn+mx5KvwhQ29cXKuERgBiJNd5avmOOKE19lZcIQ6kh
 3uxxJSC11UUiuIrOy+LyBQChw9wabrMJYNWXaLdDqXuu16X0nZN52QUSDveRslHNtuCl
 BXXj4qyzpDQ1JPs9ZBd/GgkfXTo8AmKRNyRhjYNHVLYl30PDUGiBqntOk27fc9dFU3pS
 A8jUK8co1cHmEJ3icD/Euta/XSIIFtuvTVmWPSvPb3cqZBiTUNll3ovcfjwYpsilD7is
 LzSWWkWe4G5K/M/VjdMG0n5XD087XWRmrmuKCx020YSHrncW2EMan7R1h9Sn8s035++8
 s/pg==
X-Gm-Message-State: AOAM531AchE3rl7zU3k+lYHhluvgfMgEcqtPXwZ0asc9eWFzQ9KLBtw9
 +3TQjlHGssCl18HTBFcduE0=
X-Google-Smtp-Source: ABdhPJxrzeloGWor0hMRqpgk4/JQjf7aNssOCayIltNWlZqr0CzPk9Nq31sRx+5AvFqmTPzlFGVpMA==
X-Received: by 2002:a17:90a:1a53:: with SMTP id 19mr455412pjl.19.1644547551170; 
 Thu, 10 Feb 2022 18:45:51 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com
 (220-143-207-145.dynamic-ip.hinet.net. [220.143.207.145])
 by smtp.gmail.com with ESMTPSA id q17sm25031754pfk.108.2022.02.10.18.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 18:45:50 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] iommu/vt-d: Fix list_add double add when enabling VMD and
 scalable mode
Date: Fri, 11 Feb 2022 10:45:15 +0800
Message-Id: <20220211024515.21884-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Nirmal Patel <nirmal.patel@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Adrian Huang <ahuang12@lenovo.com>

When enabling VMD and IOMMU scalable mode, the following kernel panic
call trace/kernel log is shown in Eagle Stream platform (Sapphire Rapids
CPU) during booting:

pci 0000:59:00.5: Adding to iommu group 42
...
vmd 0000:59:00.5: PCI host bridge to bus 10000:80
pci 10000:80:01.0: [8086:352a] type 01 class 0x060400
pci 10000:80:01.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
pci 10000:80:01.0: enabling Extended Tags
pci 10000:80:01.0: PME# supported from D0 D3hot D3cold
pci 10000:80:01.0: DMAR: Setup RID2PASID failed
pci 10000:80:01.0: Failed to add to iommu group 42: -16
pci 10000:80:03.0: [8086:352b] type 01 class 0x060400
pci 10000:80:03.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
pci 10000:80:03.0: enabling Extended Tags
pci 10000:80:03.0: PME# supported from D0 D3hot D3cold
list_add double add: new=ff4d61160b74b8a0, prev=ff4d611d8e245c10, next=ff4d61160b74b8a0.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.17.0-rc3+ #7
Hardware name: Lenovo ThinkSystem SR650V3/SB27A86647, BIOS ESE101Y-1.00 01/13/2022
Workqueue: events work_for_cpu_fn
RIP: 0010:__list_add_valid.cold+0x26/0x3f
Code: 9a 4a ab ff 4c 89 c1 48 c7 c7 40 0c d9 9e e8 b9 b1 fe ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 f0 0c d9 9e e8 a2 b1 fe ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 98 0c d9 9e e8 8b b1 fe
RSP: 0000:ff5ad434865b3a40 EFLAGS: 00010246
RAX: 0000000000000058 RBX: ff4d61160b74b880 RCX: ff4d61255e1fffa8
RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ffffffff9fd34f20
RBP: ff4d611d8e245c00 R08: 0000000000000000 R09: ff5ad434865b3888
R10: ff5ad434865b3880 R11: ff4d61257fdc6fe8 R12: ff4d61160b74b8a0
R13: ff4d61160b74b8a0 R14: ff4d611d8e245c10 R15: ff4d611d8001ba70
FS:  0000000000000000(0000) GS:ff4d611d5ea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ff4d611fa1401000 CR3: 0000000aa0210001 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 intel_pasid_alloc_table+0x9c/0x1d0
 dmar_insert_one_dev_info+0x423/0x540
 ? device_to_iommu+0x12d/0x2f0
 intel_iommu_attach_device+0x116/0x290
 __iommu_attach_device+0x1a/0x90
 iommu_group_add_device+0x190/0x2c0
 __iommu_probe_device+0x13e/0x250
 iommu_probe_device+0x24/0x150
 iommu_bus_notifier+0x69/0x90
 blocking_notifier_call_chain+0x5a/0x80
 device_add+0x3db/0x7b0
 ? arch_memremap_can_ram_remap+0x19/0x50
 ? memremap+0x75/0x140
 pci_device_add+0x193/0x1d0
 pci_scan_single_device+0xb9/0xf0
 pci_scan_slot+0x4c/0x110
 pci_scan_child_bus_extend+0x3a/0x290
 vmd_enable_domain.constprop.0+0x63e/0x820
 vmd_probe+0x163/0x190
 local_pci_probe+0x42/0x80
 work_for_cpu_fn+0x13/0x20
 process_one_work+0x1e2/0x3b0
 worker_thread+0x1c4/0x3a0
 ? rescuer_thread+0x370/0x370
 kthread+0xc7/0xf0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
...
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1ca00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception ]---

The following 'lspci' output shows devices '10000:80:*' are subdevices of
the VMD device 0000:59:00.5:

  $ lspci
  ...
  0000:59:00.5 RAID bus controller: Intel Corporation Volume Management Device NVMe RAID Controller (rev 20)
  ...
  10000:80:01.0 PCI bridge: Intel Corporation Device 352a (rev 03)
  10000:80:03.0 PCI bridge: Intel Corporation Device 352b (rev 03)
  10000:80:05.0 PCI bridge: Intel Corporation Device 352c (rev 03)
  10000:80:07.0 PCI bridge: Intel Corporation Device 352d (rev 03)
  10000:81:00.0 Non-Volatile memory controller: Intel Corporation NVMe Datacenter SSD [3DNAND, Beta Rock Controller]
  10000:82:00.0 Non-Volatile memory controller: Intel Corporation NVMe Datacenter SSD [3DNAND, Beta Rock Controller]

The symptom 'list_add double add' is caused by the following failure
message:

  pci 10000:80:01.0: DMAR: Setup RID2PASID failed
  pci 10000:80:01.0: Failed to add to iommu group 42: -16
  pci 10000:80:03.0: [8086:352b] type 01 class 0x060400

Device 10000:80:01.0 is the subdevice of the VMD device 0000:59:00.5,
so invoking intel_pasid_alloc_table() gets the pasid_table of the VMD
device 0000:59:00.5. Here is call path:

  intel_pasid_alloc_table
    pci_for_each_dma_alias
     get_alias_pasid_table
       search_pasid_table

pci_real_dma_dev() in pci_for_each_dma_alias() gets the real dma device
which is the VMD device 0000:59:00.5. However, pte of the VMD device
0000:59:00.5 has been configured during this message "pci 0000:59:00.5:
Adding to iommu group 42". So, the status -EBUSY is returned when
configuring pasid entry for device 10000:80:01.0.

It then invokes dmar_remove_one_dev_info() to release
'struct device_domain_info *' from iommu_devinfo_cache. But, the pasid
table is not released because of the following statement in
__dmar_remove_one_dev_info():

	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
		...
		intel_pasid_free_table(info->dev);
        }

The subsequent dmar_insert_one_dev_info() operation of device
10000:80:03.0 allocates 'struct device_domain_info *' from
iommu_devinfo_cache. The allocated address is the same address that
is released previously for device 10000:80:01.0. Finally, invoking
device_attach_pasid_table() causes the issue.

The solution is to prevent from allocating pasid table if those
devices are subdevices of the VMD device.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..5b196cfe9ed2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2738,7 +2738,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
