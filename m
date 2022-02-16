Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8683DC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 09:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3143381335;
	Wed, 16 Feb 2022 09:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDKFFFMK1S0v; Wed, 16 Feb 2022 09:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCB5B812F2;
	Wed, 16 Feb 2022 09:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D656C001A;
	Wed, 16 Feb 2022 09:13:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA152C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D724A40997
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4tANMsp9Dci for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 09:13:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C12364091F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:13:29 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id x4so1539955plb.4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 01:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=Nvww5yWMlN32//K6YB121Wa4rAmEiT7n4m5AwXyO7Zk=;
 b=PGkzHtafncLZogkzk2O+Ss52gJQaTpcAHFYMCENma9B4SHmR6XD4xlEskfJyUnvTdl
 nfFFutGDZ9zY+ZqFJm6pNo6xBcYp5W/gvYZ16fYS6uWbrZwg81BP3LAnSZ0NCpJGomap
 UpzPbdNV6lV5XA+rqkAv+RR3DrxbFojBthiVpSiOpbpqAeuJy1cLbMUU/Wly5C3VwRbI
 NQ7hKXyDZy8XTlGiK55jN1Yz3DqmdFGSNlSvFWV0XxGWzuUk6WPReGnJhMKU/77byN+m
 6HET64+m1SqWmAmFsGKM+K6UQVihwfmISJ0vskWPOrrKYl/KEUosJHw0kPkGScGiKTU7
 4Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Nvww5yWMlN32//K6YB121Wa4rAmEiT7n4m5AwXyO7Zk=;
 b=d+RtHzYx6fw8p13JyQiibFVxyNJqnngoWsBzjZ/t1x2ahf1uCHIS2aVoAM3Y/sIx69
 6k/dTmybrO27bdPtnrUGRQi5Yc5qZnfBkTDGfzGUaPoRHHgsDuMrFA7GkA8K14g7au8n
 S7igGzknnp6MfO1BSF9Q7TJj/qMTHrchFviDhEYI+BXUK0LIf/OSXrCVn4X06F1D29k2
 liufNBX8HB7A5sTuwEi72xNVToXw4O2zpiHUt3bCJGx6jEA07aNz0byMj/qt808kDIak
 96xjegyErjzRCx7i25gMIK6lcd8qU6pVG9T6cyWKzPLtNAFidRQGzIfqrMT4jFqXxuMn
 6LIA==
X-Gm-Message-State: AOAM5301OiHXHC+3i65avapd2qQoMJpV4lsj1Ln/S2SIqYnX3h+1ra3/
 xtw+UkdnlgrJnxKntNBzbYA=
X-Google-Smtp-Source: ABdhPJzrOVNGP7xwrDAx36FW3CswL2/uylES2JNgP/NbH2H6g38huwLR1S76+lpf2oZExkUMPUTk9A==
X-Received: by 2002:a17:902:eb8d:b0:14d:5027:9f00 with SMTP id
 q13-20020a170902eb8d00b0014d50279f00mr1427569plg.19.1645002809000; 
 Wed, 16 Feb 2022 01:13:29 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com
 (220-143-233-227.dynamic-ip.hinet.net. [220.143.233.227])
 by smtp.gmail.com with ESMTPSA id my18sm20216208pjb.57.2022.02.16.01.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 01:13:28 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Fix list_add double add when enabling VMD
 and scalable mode
Date: Wed, 16 Feb 2022 17:13:07 +0800
Message-Id: <20220216091307.703-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Kevin Tian <kevin.tian@intel.com>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>,
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

`git bisect` points to the offending commit 474dd1c65064 ("iommu/vt-d:
Fix clearing real DMA device's scalable-mode context entries"), which
releases the pasid table if the device is not the subdevice by
checking the returned status of dev_is_real_dma_subdevice().
Reverting the offending commit can work around the issue.

The solution is to prevent from allocating pasid table if those
devices are subdevices of the VMD device.

Fixes: 474dd1c65064 ("iommu/vt-d: Fix clearing real DMA device's scalable-mode context entries")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---

Changes since v2:
 * Add Fixes tag and stable kernel CC, per Baolu

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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
