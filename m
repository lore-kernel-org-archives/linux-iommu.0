From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v9 06/10] iommu/vt-d: datatypes and functions used for kdump
Date: Thu, 19 Mar 2015 13:36:24 +0800
Message-ID: <1426743388-26908-7-git-send-email-zhen-hual@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Populate it with support functions to copy iommu translation tables from
from the panicked kernel into the kdump kernel in the event of a crash.

Functions:
    Use old root entry table, and load the old data to root_entry as cache.
    Malloc new context table and copy old context table to the new one.

Bill Sumner:
    Original version, the creation of the data types and functions.

Li, Zhenhua:
    Update the caller of context_get_* and context_put*, use context_*
    and context_set_* for replacement.
    Update the name of the function that loads root entry table.
    Use new function to copy old context entry tables and page tables.
    Use "unsigned long" for physical address.
    Remove the functions to copy page table in Bill's version.
    Remove usage of dve and ppap in Bill's version.

Signed-off-by: Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1cb9780..44f3369 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -388,6 +388,18 @@ struct iommu_remapped_entry {
 static LIST_HEAD(__iommu_remapped_mem);
 static DEFINE_MUTEX(__iommu_mem_list_lock);
 
+/* ========================================================================
+ * Copy iommu translation tables from old kernel into new  kernel.
+ * Entry to this set of functions is: intel_iommu_load_translation_tables()
+ * ------------------------------------------------------------------------
+ */
+
+static int copy_root_entry_table(struct intel_iommu *iommu);
+
+static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd);
+
+static void unmap_device_dma(struct dmar_domain *domain, struct device *dev);
+
 #endif /* CONFIG_CRASH_DUMP */
 
 /*
@@ -4976,4 +4988,105 @@ static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
 	__iommu_flush_cache(iommu, to + start, size);
 }
 
+/*
+ * Load root entry tables from old kernel.
+ */
+static int copy_root_entry_table(struct intel_iommu *iommu)
+{
+	u32 bus;				/* Index: root-entry-table */
+	struct root_entry  *re;			/* Virt(iterator: new table) */
+	unsigned long context_old_phys;		/* Phys(context table entry) */
+	struct context_entry *context_new_virt;	/* Virt(new context_entry) */
+
+	/*
+	 * A new root entry table has been allocated ,
+	 * we need copy re from old kernel to the new allocated one.
+	 */
+
+	if (!iommu->root_entry_old_phys)
+		return -ENOMEM;
+
+	for (bus = 0, re = iommu->root_entry; bus < 256; bus += 1, re += 1) {
+		if (!root_present(re))
+			continue;
+
+		context_old_phys = get_context_phys_from_root(re);
+
+		if (!context_old_phys)
+			continue;
+
+		context_new_virt =
+			(struct context_entry *)alloc_pgtable_page(iommu->node);
+
+		if (!context_new_virt)
+			return -ENOMEM;
+
+		__iommu_load_from_oldmem(context_new_virt,
+					context_old_phys,
+					VTD_PAGE_SIZE);
+
+		__iommu_flush_cache(iommu, context_new_virt, VTD_PAGE_SIZE);
+
+		set_root_value(re, virt_to_phys(context_new_virt));
+	}
+
+	return 0;
+}
+
+/*
+ * Interface to the "load translation tables" set of functions
+ * from mainline code.
+ */
+static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd)
+{
+	struct intel_iommu *iommu;	/* Virt(iommu hardware registers) */
+	unsigned long long q;		/* quadword scratch */
+	int ret = 0;			/* Integer return code */
+	unsigned long flags;
+
+	iommu = drhd->iommu;
+	q = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	if (!q)
+		return -1;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Load the root-entry table from the old kernel
+	 * foreach context_entry_table in root_entry
+	 *   Copy each entry table from old kernel
+	 */
+	if (!iommu->root_entry) {
+		iommu->root_entry =
+			(struct root_entry *)alloc_pgtable_page(iommu->node);
+		if (!iommu->root_entry) {
+			spin_unlock_irqrestore(&iommu->lock, flags);
+			return -ENOMEM;
+		}
+	}
+
+	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
+	if (!iommu->root_entry_old_phys) {
+		pr_err("Could not read old root entry address.");
+		return -1;
+	}
+
+	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
+						VTD_PAGE_SIZE);
+	if (!iommu->root_entry_old_virt) {
+		pr_err("Could not map the old root entry.");
+		return -ENOMEM;
+	}
+
+	__iommu_load_old_root_entry(iommu);
+	ret = copy_root_entry_table(iommu);
+	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
+	__iommu_update_old_root_entry(iommu, -1);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	__iommu_free_mapped_mem();
+
+	return ret;
+}
+
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0
