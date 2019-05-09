Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5D6C04AB1
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 18:44:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB5A217D6
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 18:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB5A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 34F4EE5B;
	Thu,  9 May 2019 18:44:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 62E50A7F
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 18:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B9675875
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 18:44:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 11:44:47 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga005.jf.intel.com with ESMTP; 09 May 2019 11:44:46 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu/vt-d: Modify the format of intel DMAR tables dump
Date: Thu,  9 May 2019 11:41:58 -0700
Message-Id: <548b6045d4805e065d3308c8d8ea085eb9b39843.1556762845.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
References: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Presently, "/sys/kernel/debug/iommu/intel/dmar_translation_struct" file
dumps DMAR tables in the below format

IOMMU dmar2: Root Table Address:4362cc000
Root Table Entries:
 Bus: 0 H: 0 L: 4362f0001
 Context Table Entries for Bus: 0
  Entry	B:D.F	High	Low
  160   00:14.0	102     4362ef001
  184   00:17.0	302     435ec4001
  248   00:1f.0	202     436300001

This format has few short comings like
1. When extended for dumping scalable mode DMAR table it will quickly be
   very clumsy, making it unreadable.
2. It has information like the Bus number and Entry which are basically
   part of B:D.F, hence are a repetition and are not so useful.

So, change it to a new format which could be easily extended to dump
scalable mode DMAR table. The new format looks as below:

IOMMU dmar2: Root Table Address: 0x436f7d000
B.D.F	Root_entry				Context_entry
00:14.0	0x0000000000000000:0x0000000436fbd001	0x0000000000000102:0x0000000436fbc001
00:17.0	0x0000000000000000:0x0000000436fbd001	0x0000000000000302:0x0000000436af4001
00:1f.0	0x0000000000000000:0x0000000436fbd001	0x0000000000000202:0x0000000436fcd001

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 65 +++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 7fabf9b1c2dc..3f5399b5e6c0 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -14,6 +14,13 @@
 
 #include <asm/irq_remapping.h>
 
+struct tbl_walk {
+	u16 bus;
+	u16 devfn;
+	struct root_entry *rt_entry;
+	struct context_entry *ctx_entry;
+};
+
 struct iommu_regset {
 	int offset;
 	const char *regs;
@@ -131,16 +138,25 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
-static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
-			       int bus)
+static inline void print_tbl_walk(struct seq_file *m)
 {
-	struct context_entry *context;
-	int devfn;
+	struct tbl_walk *tbl_wlk = m->private;
 
-	seq_printf(m, " Context Table Entries for Bus: %d\n", bus);
-	seq_puts(m, "  Entry\tB:D.F\tHigh\tLow\n");
+	seq_printf(m, "%02x:%02x.%x\t0x%016llx:0x%016llx\t0x%016llx:0x%016llx\n",
+		   tbl_wlk->bus, PCI_SLOT(tbl_wlk->devfn),
+		   PCI_FUNC(tbl_wlk->devfn), tbl_wlk->rt_entry->hi,
+		   tbl_wlk->rt_entry->lo, tbl_wlk->ctx_entry->hi,
+		   tbl_wlk->ctx_entry->lo);
+}
+
+static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
+{
+	struct context_entry *context;
+	u16 devfn;
 
 	for (devfn = 0; devfn < 256; devfn++) {
+		struct tbl_walk tbl_wlk = {0};
+
 		context = iommu_context_addr(iommu, bus, devfn, 0);
 		if (!context)
 			return;
@@ -148,33 +164,34 @@ static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 		if (!context_present(context))
 			continue;
 
-		seq_printf(m, "  %-5d\t%02x:%02x.%x\t%-6llx\t%llx\n", devfn,
-			   bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
-			   context[0].hi, context[0].lo);
+		tbl_wlk.bus = bus;
+		tbl_wlk.devfn = devfn;
+		tbl_wlk.rt_entry = &iommu->root_entry[bus];
+		tbl_wlk.ctx_entry = context;
+		m->private = &tbl_wlk;
+
+		print_tbl_walk(m);
 	}
 }
 
-static void root_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 {
 	unsigned long flags;
-	int bus;
+	u16 bus;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	seq_printf(m, "IOMMU %s: Root Table Address:%llx\n", iommu->name,
+	seq_printf(m, "IOMMU %s: Root Table Address: 0x%llx\n", iommu->name,
 		   (u64)virt_to_phys(iommu->root_entry));
-	seq_puts(m, "Root Table Entries:\n");
-
-	for (bus = 0; bus < 256; bus++) {
-		if (!(iommu->root_entry[bus].lo & 1))
-			continue;
+	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\n");
 
-		seq_printf(m, " Bus: %d H: %llx L: %llx\n", bus,
-			   iommu->root_entry[bus].hi,
-			   iommu->root_entry[bus].lo);
+	/*
+	 * No need to check if the root entry is present or not because
+	 * iommu_context_addr() performs the same check before returning
+	 * context entry.
+	 */
+	for (bus = 0; bus < 256; bus++)
+		ctx_tbl_walk(m, iommu, bus);
 
-		ctx_tbl_entry_show(m, iommu, bus);
-		seq_putc(m, '\n');
-	}
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
@@ -185,7 +202,7 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
-		root_tbl_entry_show(m, iommu);
+		root_tbl_walk(m, iommu);
 		seq_putc(m, '\n');
 	}
 	rcu_read_unlock();
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
