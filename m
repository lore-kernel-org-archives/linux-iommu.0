From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/16] iommu/amd: Allocate data structures to keep track of
	irq remapping tables
Date: Fri, 28 Sep 2012 14:23:53 +0200
Message-ID: <1348835046-3262-4-git-send-email-joerg.roedel@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1348835046-3262-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To easily map device ids to interrupt remapping table
entries a new lookup table is necessary.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  |   16 ++++++++++++++++
 drivers/iommu/amd_iommu_types.h |    9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a046a0e..db100c5 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -181,6 +181,12 @@ u16 *amd_iommu_alias_table;
 struct amd_iommu **amd_iommu_rlookup_table;
 
 /*
+ * This table is used to find the irq remapping table for a given device id
+ * quickly.
+ */
+struct irq_remap_table **irq_lookup_table;
+
+/*
  * AMD IOMMU allows up to 2^16 differend protection domains. This is a bitmap
  * to know which ones are already in use.
  */
@@ -1529,9 +1535,13 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_on_init_error(void)
 {
+	free_pages((unsigned long)irq_lookup_table,
+		   get_order(rlookup_table_size));
+
 	if (amd_iommu_irq_cache) {
 		kmem_cache_destroy(amd_iommu_irq_cache);
 		amd_iommu_irq_cache = NULL;
+
 	}
 
 	amd_iommu_uninit_devices();
@@ -1684,6 +1694,12 @@ static int __init early_amd_iommu_init(void)
 				0, NULL);
 		if (!amd_iommu_irq_cache)
 			goto out;
+
+		irq_lookup_table = (void *)__get_free_pages(
+				GFP_KERNEL | __GFP_ZERO,
+				get_order(rlookup_table_size));
+		if (!irq_lookup_table)
+			goto out;
 	}
 
 	ret = init_memory_definitions(ivrs_base);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 953cea8..1a7d480 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -175,6 +175,7 @@
 #define DEV_ENTRY_EX            0x67
 #define DEV_ENTRY_SYSMGT1       0x68
 #define DEV_ENTRY_SYSMGT2       0x69
+#define DEV_ENTRY_IRQ_TBL_EN	0x80
 #define DEV_ENTRY_INIT_PASS     0xb8
 #define DEV_ENTRY_EINT_PASS     0xb9
 #define DEV_ENTRY_NMI_PASS      0xba
@@ -337,6 +338,14 @@ extern bool amd_iommu_iotlb_sup;
 #define MAX_IRQS_PER_TABLE	256
 #define IRQ_TABLE_ALIGNMENT	128
 
+struct irq_remap_table {
+	spinlock_t lock;
+	unsigned min_index;
+	u32 *table;
+};
+
+extern struct irq_remap_table **irq_lookup_table;
+
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
-- 
1.7.9.5
