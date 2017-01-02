From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 RESEND 08/12] iommu/amd: Add sanity check of irq remap
	information of old dev table entry
Date: Mon,  2 Jan 2017 15:39:54 +0800
Message-ID: <1483342798-6542-9-git-send-email-bhe@redhat.com>
References: <1483342798-6542-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483342798-6542-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Firstly split the dev table entry copy into address translation part and
irq remapping part. Because these two parts could be configured to
be available indepentently.

Secondly check if IntCtl and IntTabLen are 10b and 1000b if they are
set.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  5 -----
 drivers/iommu/amd_iommu_init.c  | 25 ++++++++++++++++++++++---
 drivers/iommu/amd_iommu_types.h |  8 ++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2005d26..c23f3d11 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3642,11 +3642,6 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 
 static struct irq_chip amd_ir_chip;
 
-#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
-#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
-#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
-#define DTE_IRQ_REMAP_ENABLE    1ULL
-
 static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 {
 	u64 dte;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 93f0ac2..9186f8b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -838,12 +838,12 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 
 static int copy_dev_tables(void)
 {
+	u64 int_ctl, int_tab_len, entry, last_entry = 0;
 	struct dev_table_entry *old_devtb = NULL;
 	u32 lo, hi, devid, old_devtb_size;
 	phys_addr_t old_devtb_phys;
-	u64 entry, last_entry = 0;
 	struct amd_iommu *iommu;
-	u16 dom_id, dte_v;
+	u16 dom_id, dte_v, irq_v;
 	static int copied;
 
 	for_each_iommu(iommu) {
@@ -882,8 +882,27 @@ static int copy_dev_tables(void)
 			amd_iommu_dev_table[devid] = old_devtb[devid];
 			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
-			if (dte_v && dom_id)
+			if (dte_v && dom_id) {
+				amd_iommu_dev_table[devid].data[0]
+					= old_devtb[devid].data[0];
+				amd_iommu_dev_table[devid].data[1]
+					= old_devtb[devid].data[1];
 				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			}
+
+			irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
+			int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
+			int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
+			if (irq_v && (int_ctl || int_tab_len)) {
+				if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
+					 (int_tab_len != DTE_IRQ_TABLE_LEN)) {
+					pr_err("Wrong old irq remapping flag: %#x\n", devid);
+					return -1;
+				}
+
+				amd_iommu_dev_table[devid].data[2]
+					= old_devtb[devid].data[2];
+			}
 		}
 		memunmap(old_devtb);
 		copied = 1;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 79ec841..b5ae18e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -250,6 +250,14 @@
 
 #define GA_GUEST_NR		0x1
 
+/* Bit value definition for dte irq remapping fields*/
+#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
+#define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
+#define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
+#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
+#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
+#define DTE_IRQ_REMAP_ENABLE    1ULL
+
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
 #define PAGE_MODE_2_LEVEL 0x02
-- 
2.5.5
