From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 5/9] iommu/amd: Add function copy_dev_tables
Date: Fri,  6 Nov 2015 20:10:47 +0800
Message-ID: <1446811851-20623-6-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e84817e..16aea93 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -703,6 +703,42 @@ static void copy_irq_table(u16 devid)
 	irq_lookup_table[devid] = table;
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
+		/*
+		 * This is used to prevent the WARNING in iommu_queue_command_sync()
+		 * when call flush function
+		 */
+		iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
+
+                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_devtb_phys = entry & PAGE_MASK;
+                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);
+                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+                        amd_iommu_dev_table[devid] = old_devtb[devid];
+                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
+			if (!dom_id)
+				continue;
+                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			copy_irq_table(devid);
+			iommu_flush_dte(iommu, devid);
+                }
+                iounmap(old_devtb);
+		iommu_completion_wait(iommu);
+        }
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 80ccc28..a481c74 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -195,6 +195,8 @@
 #define DEV_ENTRY_MODE_MASK	0x07
 #define DEV_ENTRY_MODE_SHIFT	0x09
 
+#define DEV_DOMID_MASK        0xffff
+
 #define MAX_DEV_TABLE_ENTRIES	0xffff
 
 /* constants to configure the command buffer */
-- 
2.4.0
