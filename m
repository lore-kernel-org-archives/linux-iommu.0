From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v3 07/12] iommu/amd: Add function copy_dev_tables
Date: Tue, 26 Jan 2016 18:29:21 +0800
Message-ID: <1453804166-25646-8-git-send-email-bhe@redhat.com>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Add function copy_dev_tables to copy old DTE in 1st kernel to
the new DTE table. Since all iommu share the same DTE table the
copy only need be done once as long as the physical address of
old DTE table is retrieved from iommu reg. Besides the old domain
id occupied in 1st kernel need be reserved in order to avoid touch
the old translation tables.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  2 +-
 drivers/iommu/amd_iommu_init.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 93bc690..c0b96e0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2011,7 +2011,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 		flags    |= tmp;
 	}
 
-	flags &= ~(0xffffUL);
+	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
 	amd_iommu_dev_table[devid].data[1]  = flags;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 450adad..e5d28ec 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -704,6 +704,46 @@ static void copy_irq_table(u16 devid)
 	memunmap(old_intr_virt);
 }
 
+static int copy_dev_tables(struct amd_iommu *iommu)
+{
+	u64 entry;
+	u32 lo, hi;
+	phys_addr_t old_devtb_phys;
+	struct dev_table_entry *old_devtb;
+	u16 dom_id;
+	u32 devid;
+	u64 flags = 0;
+	static int copied;
+
+        for_each_iommu(iommu) {
+		if (!translation_pre_enabled()) {
+			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
+			return -1;
+		}
+
+		if (copied)
+			continue;
+
+                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_devtb_phys = entry & PAGE_MASK;
+                old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+                        amd_iommu_dev_table[devid] = old_devtb[devid];
+                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
+			flags = amd_iommu_dev_table[devid].data[0];
+			if (!flags & IOMMU_PTE_V)
+				continue;
+                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			copy_irq_table(devid);
+                }
+		memunmap(old_devtb);
+		copied = 1;
+        }
+	return 0;
+}
+
 void amd_iommu_apply_erratum_63(u16 devid)
 {
 	int sysmgt;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 42cd3d5..9a768f6 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -303,6 +303,7 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
 #define DTE_GLX_MASK	(3)
+#define DEV_DOMID_MASK 	0xffffULL
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-- 
2.1.0
