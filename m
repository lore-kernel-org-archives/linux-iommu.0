Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB280613D
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706288; x=1719242288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGog1IvJBB3RYoMtBN+mKPewp6Oixq643V5vrMTp7ao=;
  b=frs0jY2kOoEDZsJT6mD43TcdgXbbGwopvrepz7WUpJR8Zdr4LPtNSjHq
   D5r82I80V8UoX2/3B+ztj2W5s0EHHVnIdnlDNul+r/p3uY4CN0GirTQUM
   LRhjjTxUt7ujZMdhDx98ZWIxIjJl7BT17jG0JTzETwRXV+4P6CEKsZ3bq
   HlRVH9s2gxcutxa7w4CrCrh5N+7DFRAz4182itNgu5+7xIIyteRun5R3d
   4+2cKgizKZuxnvxLDGtKox3W+rEDcaEkxbm6gTXSMf5r8oClPampq8m7Z
   5knZREGt9Yng3rzYsw9wNrfIWRocvRKNXeCLSCexXrH3q//mwdNLJujZL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255079"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255079"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004533"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004533"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:05 -0700
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 3/5] iommu/vt-d: debugfs: Dump the corresponding page table of a pasid
Date: Sun, 25 Jun 2023 23:04:40 +0800
Message-Id: <20230625150442.42197-4-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230625150442.42197-1-Jingqi.liu@intel.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic helper to dump the page table contained in a pasid table entry.

For implementations supporting Scalable Mode Translation, the PASID-table
entries contain pointers to both first-stage and second-stage translation
structures, along with the PASID Granular Translation Type (PGTT) field that
specifies which translation process the request undergoes.

The original debugfs only dumps the contents of pasid table entry when
traversing the pasid table. Add a check to decide whether to dump the page
table contained by a pasid table entry.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 59 ++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 6d02cd91718a..212d33598de9 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -19,9 +19,11 @@
 #include "perf.h"
 
 struct tbl_walk {
+	u16 segment;     /* PCI segment# */
 	u16 bus;
 	u16 devfn;
 	u32 pasid;
+	bool dump_page_table;
 	struct root_entry *rt_entry;
 	struct context_entry *ctx_entry;
 	struct pasid_entry *pasid_tbl_entry;
@@ -118,6 +120,8 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(VCRSP),
 };
 
+static void dump_translation_page_table(struct seq_file *m);
+
 static int iommu_regset_show(struct seq_file *m, void *unused)
 {
 	struct dmar_drhd_unit *drhd;
@@ -199,7 +203,11 @@ static void pasid_tbl_walk(struct seq_file *m, struct pasid_entry *tbl_entry,
 		if (pasid_pte_is_present(tbl_entry)) {
 			tbl_wlk->pasid_tbl_entry = tbl_entry;
 			tbl_wlk->pasid = (dir_idx << PASID_PDE_SHIFT) + tbl_idx;
-			print_tbl_walk(m);
+
+			if (tbl_wlk->dump_page_table)
+				dump_translation_page_table(m);
+			else
+				print_tbl_walk(m);
 		}
 
 		tbl_entry++;
@@ -347,6 +355,55 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 	}
 }
 
+/*
+ * Dump the page table that contained in a pasid table entry.
+ * There're two consumers of this helper, as follows:
+ * 1) When traversing the pasid table, dump the page table
+ *    contained in the pasid table entry.
+ * 2) Find the pasid table entry with a specified pasid,
+ *    and dump the page table it contains.
+ */
+static void dump_translation_page_table(struct seq_file *m)
+{
+	struct tbl_walk *tbl_wlk = m->private;
+	u64 pgd, path[6] = { 0 };
+	u16 pgtt;
+	u8 agaw;
+
+	if (!tbl_wlk->pasid_tbl_entry)
+		return;
+
+	/*
+	 * According to PASID Granular Translation Type(PGTT),
+	 * get the page table pointer.
+	 */
+	pgtt = (u16)(tbl_wlk->pasid_tbl_entry->val[0] & GENMASK_ULL(8, 6)) >> 6;
+	agaw = (u8)(tbl_wlk->pasid_tbl_entry->val[0] & GENMASK_ULL(4, 2)) >> 2;
+
+	switch (pgtt) {
+	case PASID_ENTRY_PGTT_FL_ONLY:
+		pgd = tbl_wlk->pasid_tbl_entry->val[2];
+		break;
+	case PASID_ENTRY_PGTT_SL_ONLY:
+	case PASID_ENTRY_PGTT_NESTED:
+		pgd = tbl_wlk->pasid_tbl_entry->val[0];
+		break;
+	default:
+		return;
+	}
+
+	pgd &= VTD_PAGE_MASK;
+	seq_printf(m, "Device %04x:%02x:%02x.%x with pasid %x @0x%llx\n",
+		   tbl_wlk->segment, tbl_wlk->bus, PCI_SLOT(tbl_wlk->devfn),
+		   PCI_FUNC(tbl_wlk->devfn), tbl_wlk->pasid, pgd);
+	seq_printf(m, "%-17s\t%-18s\t%-18s\t%-18s\t%-18s\t%-s\n",
+		   "IOVA_PFN", "PML5E", "PML4E", "PDPE", "PDE", "PTE");
+	pgtable_walk_level(m, phys_to_virt(pgd), agaw + 2, 0, path);
+	seq_putc(m, '\n');
+
+	return;
+}
+
 static int __show_device_domain_translation(struct device *dev, void *data)
 {
 	struct dmar_domain *domain;
-- 
2.21.3

