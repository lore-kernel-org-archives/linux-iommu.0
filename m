From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v9 05/13] iommu/amd: Add function copy_dev_tables()
Date: Tue,  1 Aug 2017 19:37:21 +0800
Message-ID: <1501587449-9817-6-git-send-email-bhe@redhat.com>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1501587449-9817-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add function copy_dev_tables to copy the old DEV table entries of the panicked
kernel to the new allocated device table. Since all iommus share the same device
table the copy only need be done one time. Here add a new global old_dev_tbl_cpy
to point to the newly allocated device table which the content of old device
table will be copied to. Besides, we also need to:

  - Check whether all IOMMUs actually use the same device table with the same size

  - Verify that the size of the old device table is the expected size.

  - Reserve the old domain id occupied in 1st kernel to avoid touching the old
    io-page tables. Then on-flight DMA can continue looking it up.

And also define MACRO DEV_DOMID_MASK to replace magic number 0xffffULL, it can be
reused in copy_dev_tables().

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  2 +-
 drivers/iommu/amd_iommu_init.c  | 64 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 3 files changed, 66 insertions(+), 1 deletion(-)

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
index 8896137f17af..ab6794539527 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -195,6 +195,11 @@ spinlock_t amd_iommu_pd_lock;
  * page table root pointer.
  */
 struct dev_table_entry *amd_iommu_dev_table;
+/*
+ * Pointer to a device table which the content of old device table
+ * will be copied to. It's only be used in kdump kernel.
+ */
+static struct dev_table_entry *old_dev_tbl_cpy;
 
 /*
  * The alias table is a driver specific data structure which contains the
@@ -842,6 +847,65 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 }
 
 
+static int copy_device_table(void)
+{
+	struct dev_table_entry *old_devtb = NULL;
+	u32 lo, hi, devid, old_devtb_size;
+	phys_addr_t old_devtb_phys;
+	u64 entry, last_entry = 0;
+	struct amd_iommu *iommu;
+	u16 dom_id, dte_v;
+	static int copied;
+	gfp_t gfp_flag;
+
+	for_each_iommu(iommu) {
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
+		if (copied)
+			continue;
+
+		old_devtb_phys = entry & PAGE_MASK;
+		old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+		if (!old_devtb)
+			return -1;
+
+		gfp_flag = GFP_KERNEL | __GFP_ZERO;
+		old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
+					get_order(dev_table_size));
+		if (old_dev_tbl_cpy == NULL) {
+			pr_err("Failed to allocate memory for copying old device table!/n");
+			return -1;
+		}
+
+		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+			old_dev_tbl_cpy[devid] = old_devtb[devid];
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
index f88e802481a3..a7f6cf8c841e 100644
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
