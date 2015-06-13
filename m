From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/19] iommu/vt-d: Copy translation tables from old kernel
Date: Sat, 13 Jun 2015 08:47:13 +0200
Message-ID: <1434178047-17809-6-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

If we are in a kdump kernel and find translation enabled in
the iommu, try to copy the translation tables from the old
kernel to preserve the mappings until the device driver
takes over.
This supports old and the extended root-entry and
context-table formats.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 207 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 467414b..a755f94 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -43,6 +43,7 @@
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
+#include <linux/crash_dump.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -193,7 +194,29 @@ struct root_entry {
 };
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
+/*
+ * Take a root_entry and return the Lower Context Table Pointer (LCTP)
+ * if marked present.
+ */
+static phys_addr_t root_entry_lctp(struct root_entry *re)
+{
+	if (!(re->lo & 1))
+		return 0;
+
+	return re->lo & VTD_PAGE_MASK;
+}
+
+/*
+ * Take a root_entry and return the Upper Context Table Pointer (UCTP)
+ * if marked present.
+ */
+static phys_addr_t root_entry_uctp(struct root_entry *re)
+{
+	if (!(re->hi & 1))
+		return 0;
 
+	return re->hi & VTD_PAGE_MASK;
+}
 /*
  * low 64 bits:
  * 0: present
@@ -440,6 +463,11 @@ static bool translation_pre_enabled(struct intel_iommu *iommu)
 	return (iommu->flags & VTD_FLAG_TRANS_PRE_ENABLED);
 }
 
+static void clear_translation_pre_enabled(struct intel_iommu *iommu)
+{
+	iommu->flags &= ~VTD_FLAG_TRANS_PRE_ENABLED;
+}
+
 static void init_translation_status(struct intel_iommu *iommu)
 {
 	u32 gsts;
@@ -2748,6 +2776,153 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 	}
 }
 
+static int copy_context_table(struct intel_iommu *iommu,
+			      struct root_entry *old_re,
+			      struct context_entry **tbl,
+			      int bus, bool ext)
+{
+	struct context_entry *old_ce = NULL, *new_ce = NULL, ce;
+	int tbl_idx, pos = 0, idx, devfn, ret = 0;
+	phys_addr_t old_ce_phys;
+
+	tbl_idx = ext ? bus * 2 : bus;
+
+	for (devfn = 0; devfn < 256; devfn++) {
+		/* First calculate the correct index */
+		idx = (ext ? devfn * 2 : devfn) % 256;
+
+		if (idx == 0) {
+			/* First save what we may have and clean up */
+			if (new_ce) {
+				tbl[tbl_idx] = new_ce;
+				__iommu_flush_cache(iommu, new_ce,
+						    VTD_PAGE_SIZE);
+				pos = 1;
+			}
+
+			if (old_ce)
+				iounmap(old_ce);
+
+			ret = 0;
+			if (devfn < 0x80)
+				old_ce_phys = root_entry_lctp(old_re);
+			else
+				old_ce_phys = root_entry_uctp(old_re);
+
+			if (!old_ce_phys) {
+				if (ext && devfn == 0) {
+					/* No LCTP, try UCTP */
+					devfn = 0x7f;
+					continue;
+				} else {
+					goto out;
+				}
+			}
+
+			ret = -ENOMEM;
+			old_ce = ioremap_cache(old_ce_phys, PAGE_SIZE);
+			if (!old_ce)
+				goto out;
+
+			new_ce = alloc_pgtable_page(iommu->node);
+			if (!new_ce)
+				goto out_unmap;
+
+			ret = 0;
+		}
+
+		/* Now copy the context entry */
+		ce = old_ce[idx];
+
+		if (!context_present(&ce))
+			continue;
+
+		new_ce[idx] = ce;
+	}
+
+	tbl[tbl_idx + pos] = new_ce;
+
+	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
+
+out_unmap:
+	iounmap(old_ce);
+
+out:
+	return ret;
+}
+
+static int copy_translation_tables(struct intel_iommu *iommu)
+{
+	struct context_entry **ctxt_tbls;
+	struct root_entry *old_rt;
+	phys_addr_t old_rt_phys;
+	int ctxt_table_entries;
+	unsigned long flags;
+	u64 rtaddr_reg;
+	int bus, ret;
+	bool ext;
+
+	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
+
+	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
+	if (!old_rt_phys)
+		return -EINVAL;
+
+	old_rt = ioremap_cache(old_rt_phys, PAGE_SIZE);
+	if (!old_rt)
+		return -ENOMEM;
+
+	/* This is too big for the stack - allocate it from slab */
+	ctxt_table_entries = ext ? 512 : 256;
+	ret = -ENOMEM;
+	ctxt_tbls = kzalloc(ctxt_table_entries * sizeof(void *), GFP_KERNEL);
+	if (!ctxt_tbls)
+		goto out_unmap;
+
+	for (bus = 0; bus < 256; bus++) {
+		ret = copy_context_table(iommu, &old_rt[bus],
+					 ctxt_tbls, bus, ext);
+		if (ret) {
+			pr_err("%s: Failed to copy context table for bus %d\n",
+				iommu->name, bus);
+			continue;
+		}
+	}
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Context tables are copied, now write them to the root_entry table */
+	for (bus = 0; bus < 256; bus++) {
+		int idx = ext ? bus * 2 : bus;
+		u64 val;
+
+		if (ctxt_tbls[idx]) {
+			val = virt_to_phys(ctxt_tbls[idx]) | 1;
+			iommu->root_entry[bus].lo = val;
+		}
+
+		if (!ext || !ctxt_tbls[idx + 1])
+			continue;
+
+		val = virt_to_phys(ctxt_tbls[idx + 1]) | 1;
+		iommu->root_entry[bus].hi = val;
+	}
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	kfree(ctxt_tbls);
+
+	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
+
+	ret = 0;
+
+out_unmap:
+	iounmap(old_rt);
+
+	return ret;
+}
+
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -2805,8 +2980,12 @@ static int __init init_dmars(void)
 
 		init_translation_status(iommu);
 
-		if (translation_pre_enabled(iommu))
-			pr_info("Translation already enabled - trying to copy translation structures\n");
+		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+			iommu_disable_translation(iommu);
+			clear_translation_pre_enabled(iommu);
+			pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
+				iommu->name);
+		}
 
 		/*
 		 * TBD:
@@ -2817,6 +2996,30 @@ static int __init init_dmars(void)
 		if (ret)
 			goto free_iommu;
 
+		if (translation_pre_enabled(iommu)) {
+			pr_info("Translation already enabled - trying to copy translation structures\n");
+
+			ret = copy_translation_tables(iommu);
+			if (ret) {
+				/*
+				 * We found the IOMMU with translation
+				 * enabled - but failed to copy over the
+				 * old root-entry table. Try to proceed
+				 * by disabling translation now and
+				 * allocating a clean root-entry table.
+				 * This might cause DMAR faults, but
+				 * probably the dump will still succeed.
+				 */
+				pr_err("Failed to copy translation tables from previous kernel for %s\n",
+				       iommu->name);
+				iommu_disable_translation(iommu);
+				clear_translation_pre_enabled(iommu);
+			} else {
+				pr_info("Copied translation tables from previous kernel for %s\n",
+					iommu->name);
+			}
+		}
+
 		iommu_flush_write_buffer(iommu);
 		iommu_set_root_entry(iommu);
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-- 
1.9.1
