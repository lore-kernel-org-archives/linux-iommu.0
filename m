Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B75C433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:42:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42829604E9
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42829604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02D0340722;
	Thu, 14 Oct 2021 05:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcBwwH03NYjO; Thu, 14 Oct 2021 05:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B685940705;
	Thu, 14 Oct 2021 05:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9548EC000D;
	Thu, 14 Oct 2021 05:42:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B017C001C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DE33607BA
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_qiHPCUabwM for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2964860AC5
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214543999"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="214543999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 22:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="626685207"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 22:42:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/9] iommu/vt-d: Dump DMAR translation structure when DMA
 fault occurs
Date: Thu, 14 Oct 2021 13:38:32 +0800
Message-Id: <20211014053839.727419-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014053839.727419-1-baolu.lu@linux.intel.com>
References: <20211014053839.727419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Longpeng <longpeng2@huawei.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Kyung Min Park <kyung.min.park@intel.com>

When the dmar translation fault happens, the kernel prints a single line
fault reason with corresponding hexadecimal code defined in the Intel VT-d
specification.

Currently, when user wants to debug the translation fault in detail,
debugfs is used for dumping the dmar_translation_struct, which is not
available when the kernel failed to boot.

Dump the DMAR translation structure, pagewalk the IO page table and print
the page table entry when the fault happens.

This takes effect only when CONFIG_DMAR_DEBUG is enabled.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Link: https://lore.kernel.org/r/20210815203845.31287-1-kyung.min.park@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dmar.h        |   8 +++
 drivers/iommu/intel/dmar.c  |  10 +++-
 drivers/iommu/intel/iommu.c | 113 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/Kconfig |   4 ++
 4 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff27..45e903d84733 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -131,6 +131,14 @@ static inline int dmar_res_noop(struct acpi_dmar_header *hdr, void *arg)
 	return 0;
 }
 
+#ifdef CONFIG_DMAR_DEBUG
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
+			  unsigned long long addr, u32 pasid);
+#else
+static inline void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
+					unsigned long long addr, u32 pasid) {}
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_detected, no_iommu;
 extern int intel_iommu_init(void);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b7708b93f3fa..915bff76fe96 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1941,12 +1941,16 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
-	if (fault_type == INTR_REMAP)
+	if (fault_type == INTR_REMAP) {
 		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
-	else if (pasid == INVALID_IOASID)
+
+		return 0;
+	}
+
+	if (pasid == INVALID_IOASID)
 		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -1959,6 +1963,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 
+	dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9a356075d345..abb2599998b1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -156,6 +156,8 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
+static inline struct device_domain_info *
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -996,6 +998,117 @@ static void free_context_table(struct intel_iommu *iommu)
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+#ifdef CONFIG_DMAR_DEBUG
+static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info;
+	struct dma_pte *parent, *pte;
+	struct dmar_domain *domain;
+	int offset, level;
+
+	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	if (!info || !info->domain) {
+		pr_info("device [%02x:%02x.%d] not probed\n",
+			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return;
+	}
+
+	domain = info->domain;
+	level = agaw_to_level(domain->agaw);
+	parent = domain->pgd;
+	if (!parent) {
+		pr_info("no page table setup\n");
+		return;
+	}
+
+	while (1) {
+		offset = pfn_level_offset(pfn, level);
+		pte = &parent[offset];
+		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
+			pr_info("PTE not present at level %d\n", level);
+			break;
+		}
+
+		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
+
+		if (level == 1)
+			break;
+
+		parent = phys_to_virt(dma_pte_addr(pte));
+		level--;
+	}
+}
+
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
+			  unsigned long long addr, u32 pasid)
+{
+	struct pasid_dir_entry *dir, *pde;
+	struct pasid_entry *entries, *pte;
+	struct context_entry *ctx_entry;
+	struct root_entry *rt_entry;
+	u8 devfn = source_id & 0xff;
+	u8 bus = source_id >> 8;
+	int i, dir_index, index;
+
+	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
+
+	/* root entry dump */
+	rt_entry = &iommu->root_entry[bus];
+	if (!rt_entry) {
+		pr_info("root table entry is not present\n");
+		return;
+	}
+
+	if (sm_supported(iommu))
+		pr_info("scalable mode root entry: hi 0x%016llx, low 0x%016llx\n",
+			rt_entry->hi, rt_entry->lo);
+	else
+		pr_info("root entry: 0x%016llx", rt_entry->lo);
+
+	/* context entry dump */
+	ctx_entry = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!ctx_entry) {
+		pr_info("context table entry is not present\n");
+		return;
+	}
+
+	pr_info("context entry: hi 0x%016llx, low 0x%016llx\n",
+		ctx_entry->hi, ctx_entry->lo);
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
+	pr_info("pasid dir entry: 0x%016llx\n", pde->val);
+
+	/* get the pointer to the pasid table entry */
+	entries = get_pasid_table_from_pde(pde);
+	if (!entries) {
+		pr_info("pasid table entry is not present\n");
+		return;
+	}
+	index = pasid & PASID_PTE_MASK;
+	pte = &entries[index];
+	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
+		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
+
+pgtable_walk:
+	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn);
+}
+#endif
+
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 0ddb77115be7..247d0f2d5fdf 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -6,6 +6,9 @@ config DMAR_TABLE
 config DMAR_PERF
 	bool
 
+config DMAR_DEBUG
+	bool
+
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64)
@@ -31,6 +34,7 @@ config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
 	depends on IOMMU_DEBUGFS
 	select DMAR_PERF
+	select DMAR_DEBUG
 	help
 	  !!!WARNING!!!
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
