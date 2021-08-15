Return-Path: <SRS0=nnIB=NG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA769C4338F
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 20:45:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551D061373
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 20:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 551D061373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F107402FD;
	Sun, 15 Aug 2021 20:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65gZx7sA9RVY; Sun, 15 Aug 2021 20:45:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6F5D402A6;
	Sun, 15 Aug 2021 20:45:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A3EFC001A;
	Sun, 15 Aug 2021 20:45:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E08C000E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 20:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABC6980D02
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 20:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmyD0UHqstFr for <iommu@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 20:45:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07F4D80CF4
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 20:45:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="213914678"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; d="scan'208";a="213914678"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2021 13:45:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; d="scan'208";a="461851824"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.109])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2021 13:45:34 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/vt-d: Dump DMAR translation structure
Date: Sun, 15 Aug 2021 13:38:45 -0700
Message-Id: <20210815203845.31287-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: ravi.v.shankar@intel.com, baolu.lu@intel.com, dwmw2@infradead.org,
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

This is enabled by CONFIG_IOMMU_DEBUGFS.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
ChangeLog:
- Change from v2 to v3:
  1. Add config option for dmar_fault_dump_ptes for debug.
- Change from v1 to v2:
  1. fix compilation issue with different IOMMU config option.
---
 drivers/iommu/intel/Kconfig |   4 ++
 drivers/iommu/intel/dmar.c  |  10 +++-
 drivers/iommu/intel/iommu.c | 109 ++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |   8 +++
 4 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 43ebd8af11c5..cd209f051833 100644
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
@@ -29,6 +32,7 @@ config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
 	depends on INTEL_IOMMU && IOMMU_DEBUGFS
 	select DMAR_PERF
+	select DMAR_DEBUG
 	help
 	  !!!WARNING!!!
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d66f79acd14d..b632336902e3 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1943,12 +1943,16 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
-	if (fault_type == INTR_REMAP)
+	if (fault_type == INTR_REMAP) {
 		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
-	else if (pasid == INVALID_IOASID)
+
+		return 0;
+	}
+
+	if (pasid == INVALID_IOASID)
 		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -1961,6 +1965,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 
+	dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6a07d985709..f82ae18f3915 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -173,6 +173,8 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
+static inline struct device_domain_info *
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -998,6 +1000,113 @@ static void free_context_table(struct intel_iommu *iommu)
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+#ifdef CONFIG_DMAR_DEBUG
+static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u8 devfn)
+{
+	struct dma_pte *parent, *pte = NULL;
+	struct device_domain_info *info;
+	struct dmar_domain *domain = NULL;
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
+	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
+		pr_info("%s, pasid_table_entry[%d]: %llx\n", iommu->name, i, pte->val[i]);
+
+pgtable_walk:
+	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn);
+}
+#endif
+
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
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
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
