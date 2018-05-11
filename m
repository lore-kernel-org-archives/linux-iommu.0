From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 23/40] iommu/arm-smmu-v3: Share process page tables
Date: Fri, 11 May 2018 20:06:24 +0100
Message-ID: <20180511190641.23008-24-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
into two sets, shared and private. Shared ASIDs correspond to those
obtained from the arch ASID allocator, and private ASIDs are used for
"classic" map/unmap DMA.

Replace the ASID IDA with an IDR, allowing to keep information about each
context. Initialize shared contexts with info obtained from the mm.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3-context.c | 182 ++++++++++++++++++++++++++--
 1 file changed, 172 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index d68da99aa472..352cba3c1a62 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -10,8 +10,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/mmu_context.h>
 #include <linux/slab.h>
 
+#include "io-pgtable-arm.h"
 #include "iommu-pasid-table.h"
 
 /*
@@ -69,6 +71,9 @@ struct arm_smmu_cd {
 	u64				ttbr;
 	u64				tcr;
 	u64				mair;
+
+	refcount_t			refs;
+	struct mm_struct		*mm;
 };
 
 #define pasid_entry_to_cd(entry) \
@@ -100,7 +105,8 @@ struct arm_smmu_cd_tables {
 #define pasid_ops_to_tables(ops) \
 	pasid_to_cd_tables(iommu_pasid_table_ops_to_table(ops))
 
-static DEFINE_IDA(asid_ida);
+static DEFINE_SPINLOCK(asid_lock);
+static DEFINE_IDR(asid_idr);
 
 static int arm_smmu_alloc_cd_leaf_table(struct device *dev,
 					struct arm_smmu_cd_table *desc,
@@ -239,7 +245,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 #ifdef __BIG_ENDIAN
 		      CTXDESC_CD_0_ENDI |
 #endif
-		      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+		      (cd->mm ? 0 : CTXDESC_CD_0_ASET) |
 		      CTXDESC_CD_0_AA64 |
 		      FIELD_PREP(CTXDESC_CD_0_ASID, cd->entry.tag) |
 		      CTXDESC_CD_0_V;
@@ -255,18 +262,161 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 	return 0;
 }
 
+static bool arm_smmu_free_asid(struct arm_smmu_cd *cd)
+{
+	bool free;
+	struct arm_smmu_cd *old_cd;
+
+	spin_lock(&asid_lock);
+	free = refcount_dec_and_test(&cd->refs);
+	if (free) {
+		old_cd = idr_remove(&asid_idr, (u16)cd->entry.tag);
+		WARN_ON(old_cd != cd);
+	}
+	spin_unlock(&asid_lock);
+
+	return free;
+}
+
 static void arm_smmu_free_cd(struct iommu_pasid_entry *entry)
 {
 	struct arm_smmu_cd *cd = pasid_entry_to_cd(entry);
 
-	ida_simple_remove(&asid_ida, (u16)entry->tag);
+	if (!arm_smmu_free_asid(cd))
+		return;
+
+	if (cd->mm) {
+		/* Unpin ASID */
+		mm_context_put(cd->mm);
+	}
+
 	kfree(cd);
 }
 
+static struct arm_smmu_cd *arm_smmu_alloc_cd(struct arm_smmu_cd_tables *tbl)
+{
+	struct arm_smmu_cd *cd;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return NULL;
+
+	cd->entry.release = arm_smmu_free_cd;
+	refcount_set(&cd->refs, 1);
+
+	return cd;
+}
+
+static struct arm_smmu_cd *arm_smmu_share_asid(u16 asid)
+{
+	struct arm_smmu_cd *cd;
+
+	cd = idr_find(&asid_idr, asid);
+	if (!cd)
+		return NULL;
+
+	if (cd->mm) {
+		/*
+		 * It's pretty common to find a stale CD when doing unbind-bind,
+		 * given that the release happens after a RCU grace period.
+		 * Simply reuse it.
+		 */
+		refcount_inc(&cd->refs);
+		return cd;
+	}
+
+	/*
+	 * Ouch, ASID is already in use for a private cd.
+	 * TODO: seize it, for the common good.
+	 */
+	return ERR_PTR(-EEXIST);
+}
+
 static struct iommu_pasid_entry *
 arm_smmu_alloc_shared_cd(struct iommu_pasid_table_ops *ops, struct mm_struct *mm)
 {
-	return ERR_PTR(-ENODEV);
+	u16 asid;
+	u64 tcr, par, reg;
+	int ret = -ENOMEM;
+	struct arm_smmu_cd *cd;
+	struct arm_smmu_cd *old_cd = NULL;
+	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
+
+	asid = mm_context_get(mm);
+	if (!asid)
+		return ERR_PTR(-ESRCH);
+
+	cd = arm_smmu_alloc_cd(tbl);
+	if (!cd)
+		goto err_put_context;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&asid_lock);
+	old_cd = arm_smmu_share_asid(asid);
+	if (!old_cd)
+		ret = idr_alloc(&asid_idr, cd, asid, asid + 1, GFP_ATOMIC);
+	spin_unlock(&asid_lock);
+	idr_preload_end();
+
+	if (!IS_ERR_OR_NULL(old_cd)) {
+		if (WARN_ON(old_cd->mm != mm)) {
+			ret = -EINVAL;
+			goto err_free_cd;
+		}
+		kfree(cd);
+		mm_context_put(mm);
+		return &old_cd->entry;
+	} else if (old_cd) {
+		ret = PTR_ERR(old_cd);
+		goto err_free_cd;
+	}
+
+	tcr = TCR_T0SZ(VA_BITS) | TCR_IRGN0_WBWA | TCR_ORGN0_WBWA |
+		TCR_SH0_INNER | ARM_LPAE_TCR_EPD1;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		tcr |= TCR_TG0_4K;
+		break;
+	case SZ_16K:
+		tcr |= TCR_TG0_16K;
+		break;
+	case SZ_64K:
+		tcr |= TCR_TG0_64K;
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto err_free_asid;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	cd->ttbr	= virt_to_phys(mm->pgd);
+	cd->tcr		= tcr;
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cd->mair	= read_sysreg(mair_el1);
+
+	cd->mm		= mm;
+	cd->entry.tag	= asid;
+
+	return &cd->entry;
+
+err_free_asid:
+	arm_smmu_free_asid(cd);
+
+err_free_cd:
+	kfree(cd);
+
+err_put_context:
+	mm_context_put(mm);
+
+	return ERR_PTR(ret);
 }
 
 static struct iommu_pasid_entry *
@@ -280,20 +430,23 @@ arm_smmu_alloc_priv_cd(struct iommu_pasid_table_ops *ops,
 	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
 	struct arm_smmu_context_cfg *ctx_cfg = &tbl->pasid.cfg.arm_smmu;
 
-	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	cd = arm_smmu_alloc_cd(tbl);
 	if (!cd)
 		return ERR_PTR(-ENOMEM);
 
-	asid = ida_simple_get(&asid_ida, 0, 1 << ctx_cfg->asid_bits,
-			      GFP_KERNEL);
+	idr_preload(GFP_KERNEL);
+	spin_lock(&asid_lock);
+	asid = idr_alloc_cyclic(&asid_idr, cd, 0, 1 << ctx_cfg->asid_bits,
+				GFP_ATOMIC);
+	cd->entry.tag = asid;
+	spin_unlock(&asid_lock);
+	idr_preload_end();
+
 	if (asid < 0) {
 		kfree(cd);
 		return ERR_PTR(asid);
 	}
 
-	cd->entry.tag = asid;
-	cd->entry.release = arm_smmu_free_cd;
-
 	switch (fmt) {
 	case ARM_64_LPAE_S1:
 		cd->ttbr	= cfg->arm_lpae_s1_cfg.ttbr[0];
@@ -330,11 +483,20 @@ static void arm_smmu_clear_cd(struct iommu_pasid_table_ops *ops, int pasid,
 			      struct iommu_pasid_entry *entry)
 {
 	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
+	struct arm_smmu_cd *cd = pasid_entry_to_cd(entry);
 
 	if (WARN_ON(pasid > (1 << tbl->pasid.cfg.order)))
 		return;
 
 	arm_smmu_write_ctx_desc(tbl, pasid, NULL);
+
+	/*
+	 * The ASID allocator won't broadcast the final TLB invalidations for
+	 * this ASID, so we need to do it manually. For private contexts,
+	 * freeing io-pgtable ops performs the invalidation.
+	 */
+	if (cd->mm)
+		iommu_pasid_flush_tlbs(&tbl->pasid, pasid, entry);
 }
 
 static struct iommu_pasid_table *
-- 
2.17.0
