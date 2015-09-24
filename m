From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/10] iommu/amd: Add function copy_dev_tables
Date: Thu, 24 Sep 2015 14:37:31 +0800
Message-ID: <1443076656-31776-6-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1fc369e..913a718 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -690,6 +690,32 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
 }
 
+static void copy_dev_tables(void)
+{
+        u64 entry;
+        u32 lo, hi;
+        phys_addr_t old_devtb_phys;
+        struct dev_table_entry *old_devtb;
+        struct amd_iommu *iommu;
+        u16 dom_id;
+        u32 devid;
+
+        for_each_iommu(iommu) {
+                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_devtb_phys = entry & PAGE_MASK;
+                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);
+                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+                        amd_iommu_dev_table[devid] = old_devtb[devid];
+                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
+                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+                }
+                iounmap(old_devtb);
+        }
+
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f659088..d0f0cfb 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -194,6 +194,8 @@
 #define DEV_ENTRY_MODE_MASK	0x07
 #define DEV_ENTRY_MODE_SHIFT	0x09
 
+#define DEV_DOMID_MASK        0xffff
+
 #define MAX_DEV_TABLE_ENTRIES	0xffff
 
 /* constants to configure the command buffer */
-- 
2.4.0
