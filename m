Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39CC4708A
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 23:37:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E0B613D3
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 23:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E0B613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2EC760668;
	Wed, 26 May 2021 23:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qp5gvTHvr7JN; Wed, 26 May 2021 23:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A3A36069C;
	Wed, 26 May 2021 23:37:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D005C000D;
	Wed, 26 May 2021 23:37:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8608AC0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 23:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F30E83A46
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 23:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uEEZsiaoWZnG for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 23:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36FF883A35
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 23:37:20 +0000 (UTC)
IronPort-SDR: Jhcq0IBjuNmFpu1mge8lHKD2gXs/1nizXK9eU3I3vvks3qGyss1Kbg+PbdXSQP4GLaX1uhrNki
 Smfz4omYwU6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182941550"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="182941550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2021 16:37:11 -0700
IronPort-SDR: VGMGcsHaBfMVaw3+OeLJgmirYTGOsyb4Z2xgVD4XttQKVzXL8F2cS9jQ+3jma4oEDBvMo4NTS7
 G77JYYK7WG0g==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="633708385"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2021 16:37:10 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Dump DMAR translation structure
Date: Wed, 26 May 2021 16:35:49 -0700
Message-Id: <20210526233549.31569-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: ravi.v.shankar@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 kyung.min.park@intel.com, will@kernel.org
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

When the dmar translation fault happens, the kernel prints a single line
fault reason with corresponding hexadecimal code defined in the Intel VT-d
specification.

Currently, when user wants to debug the translation fault in detail,
debugfs is used for dumping the dmar_translation_struct, which is not
available when the kernel failed to boot.

Dump the DMAR translation structure, pagewalk the IO page table and print
the page table entry when the fault happens.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/dmar.c  |   7 ++-
 drivers/iommu/intel/iommu.c | 108 ++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |   3 +
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 11e37d2c2af2..6f4be1be8917 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1915,18 +1915,21 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
-	else if (pasid == INVALID_IOASID)
+	else if (pasid == INVALID_IOASID) {
 		pr_err("[%s w/o PASID] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
-	else
+		dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+	} else {
 		pr_err("[%s w/ PASID %x] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
+		dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 708f430af1c4..dbd11993ccfa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -172,6 +172,8 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
+static inline struct device_domain_info *
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -998,6 +1000,112 @@ static void free_context_table(struct intel_iommu *iommu)
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u8 devfn)
+{
+	struct dma_pte *parent, *pte = NULL;
+	struct dmar_domain *domain = NULL;
+	struct device_domain_info *info;
+	int offset, level;
+
+	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	if (!info) {
+		pr_info("no iommu info for this device.\n");
+		return;
+	}
+
+	domain = info->domain;
+	if (!domain) {
+		pr_info("iommu domain does not exist for this device.\n");
+		return;
+	}
+	level = agaw_to_level(domain->agaw);
+	parent = domain->pgd;
+	if (!parent) {
+		pr_info("NULL pointer of page table entry.\n");
+		return;
+	}
+
+	while (1) {
+		offset = pfn_level_offset(pfn, level);
+		pte = &parent[offset];
+		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
+			pr_info("pte not present at level %d", level);
+			break;
+		}
+		pr_info("pte level: %d, pte value: %llx\n", level, pte->val);
+
+		if (level == 1)
+			break;
+		parent = phys_to_virt(dma_pte_addr(pte));
+		level--;
+	}
+}
+
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id, unsigned long long addr,
+			  u32 pasid)
+{
+	struct pasid_dir_entry *dir, *pde;
+	struct pasid_entry *entries, *pte;
+	struct context_entry *ctx_entry;
+	struct root_entry *rt_entry;
+	u8 devfn = source_id & 0xff;
+	u8 bus = source_id >> 8;
+	int i, dir_index, index;
+
+	/* root entry dump */
+	rt_entry = &iommu->root_entry[bus];
+	if (!rt_entry) {
+		pr_info("root table entry is not present\n");
+		return;
+	}
+	if (!sm_supported(iommu))
+		pr_info("%s, root_entry[63:0]: %llx", iommu->name, rt_entry->lo);
+	else
+		pr_info("%s, root_entry[127:0]: %llx, %llx\n", iommu->name,
+			rt_entry->hi, rt_entry->lo);
+
+	/* context entry dump */
+	ctx_entry = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!ctx_entry) {
+		pr_info("context table entry is not present\n");
+		return;
+	}
+	pr_info("%s, ctx_entry[127:0]: %llx, %llx\n", iommu->name, ctx_entry->hi, ctx_entry->lo);
+
+	/* legacy mode does not require PASID entries */
+	if (!sm_supported(iommu))
+		goto pgtable_walk;
+
+	/* get the pointer to pasid directory entry */
+	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
+	if (!dir) {
+		pr_info("pasid directory entry is not present\n");
+		return;
+	}
+	/* For request-without-pasid, get the pasid from context entry */
+	if (intel_iommu_sm && pasid == INVALID_IOASID)
+		pasid = PASID_RID2PASID;
+
+	dir_index = pasid >> PASID_PDE_SHIFT;
+	pde = &dir[dir_index];
+	pr_info("%s, pasid_dir_entry: %llx\n", iommu->name, pde->val);
+
+	/* get the pointer to the pasid table entry */
+	entries = get_pasid_table_from_pde(pde);
+	if (!entries) {
+		pr_info("pasid table entry is not present\n");
+		return;
+	}
+	index = pasid & PASID_PTE_MASK;
+	pte = &entries[index];
+	/* VT-d specification defines only 3 pasid table entries currently */
+	for (i = 0; i < 3; i++)
+		pr_info("%s, pasid_table_entry[%d]: %llx\n", iommu->name, i, pte->val[i]);
+
+pgtable_walk:
+	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn);
+}
+
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff27..7b43741b79ee 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -70,6 +70,9 @@ struct dmar_pci_notify_info {
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
 
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
+			  unsigned long long addr, u32 pasid);
+
 #define for_each_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
 				dmar_rcu_check())
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
