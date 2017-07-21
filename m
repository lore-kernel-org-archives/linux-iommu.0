From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 21 Jul 2017 16:59:03 +0800
Message-ID: <1500627551-12930-6-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Add function copy_dev_tables to copy the old DEV table entries of the panicked
kernel to the new allocated DEV table. Since all iommus share the same DTE table
the copy only need be done one time. Besides, we also need to:

  - Check whether all IOMMUs actually use the same device table with the same size

  - Verify that the size of the old device table is the expected size.

  - Reserve the old domain id occupied in 1st kernel to avoid touching the old
    io-page tables. Then on-flight DMA can continue looking it up.

And also define MACRO DEV_DOMID_MASK to replace magic number 0xffffULL, it can be
reused in copy_dev_tables().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c       |  2 +-
 drivers/iommu/amd_iommu_init.c  | 55 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e5a03f259986..4d00f1bda900 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2086,7 +2086,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 		flags    |= tmp;
 	}
 
-	flags &= ~(0xffffUL);
+	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
 	amd_iommu_dev_table[devid].data[1]  = flags;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f6da5fe03b31..c58f091ce232 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -842,6 +842,61 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 }
 
 
+static int copy_dev_tables(void)
+{
+	struct dev_table_entry *old_devtb = NULL;
+	u32 lo, hi, devid, old_devtb_size;
+	phys_addr_t old_devtb_phys;
+	u64 entry, last_entry = 0;
+	struct amd_iommu *iommu;
+	u16 dom_id, dte_v;
+	static int copied;
+
+	for_each_iommu(iommu) {
+		if (!translation_pre_enabled(iommu)) {
+			pr_err("IOMMU:%d is not pre-enabled!/n",
+				iommu->index);
+			return -1;
+		}
+
+		/* All IOMMUs should use the same device table with the same size */
+		lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+		entry = (((u64) hi) << 32) + lo;
+		if (last_entry && last_entry != entry) {
+			pr_err("IOMMU:%d should use the same dev table as others!/n",
+				iommu->index);
+			return -1;
+		}
+		last_entry = entry;
+
+		old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
+		if (old_devtb_size != dev_table_size) {
+			pr_err("The device table size of IOMMU:%d is not expected!/n",
+				iommu->index);
+			return -1;
+		}
+
+		old_devtb_phys = entry & PAGE_MASK;
+		old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+		if (!old_devtb)
+			return -1;
+
+		if (copied)
+			continue;
+		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+			amd_iommu_dev_table[devid] = old_devtb[devid];
+			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
+			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
+			if (dte_v && dom_id)
+				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+		}
+		memunmap(old_devtb);
+		copied = 1;
+	}
+	return 0;
+}
+
 void amd_iommu_apply_erratum_63(u16 devid)
 {
 	int sysmgt;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index ea36af19b5b9..1c06bcc06f5c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -336,6 +336,7 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
 #define DTE_GLX_MASK	(3)
+#define DEV_DOMID_MASK	0xffffULL
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-- 
2.5.5
