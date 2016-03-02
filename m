From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Assign old irt entries a common valid vector in
	kdump kernel
Date: Wed,  2 Mar 2016 18:02:28 +0800
Message-ID: <1456912948-5052-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ZhenHua Li <zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently, the kernel copies the old irt entries during iommu
initialization for kdump, so old vectors in the first kernel are
used but having no related kernel irq handlers set explicitly,
this can lead to some problems after lapics are enabled:
 - When some in-flight dma finished and triggered an interrupt,
   the kernel will throw a warning message in do_IRQ() like "No
   irq handler", because handle_irq() will return false with no
   irq_desc handlers. This may confuse users.
 - When the in-flight dma interrupt arrives, and if there happens
   to be an irq with the same vector allocated in kdump kernel,
   it will invoke the existing ISR registered in kdump kernel as
   if one valid interrupt in the kdump kernel happens. This might
   cause some wrong software logic, for example if the ISR always
   wakes up a process.

This patch addresses the issue by modifying the old irt entries
to use a special allocated vector and related irq handler.

Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 78 ++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index ac59692..e044e0f 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -400,6 +400,68 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	return 0;
 }
 
+/*
+ * Old entries may contain vector data with no related irq handlers
+ * in the new kernel, replace them with this common vector assigned
+ * with related irq handler.
+ */
+static u8 redirected_vector;
+
+static void lapic_mask_ack(struct irq_data *dummy)
+{
+	/* We don't know how to mask it, only do lapic-level ack */
+	ack_APIC_irq();
+}
+
+static struct irq_chip fake_chip = {
+	.irq_mask_ack = lapic_mask_ack,
+};
+
+/* Allocate the common vector for all iommus' old irte */
+static void iommu_alloc_redirected_vector(struct intel_iommu *iommu)
+{
+	struct irq_alloc_info info;
+	int irq;
+
+	if (redirected_vector)
+		return;
+
+	init_irq_alloc_info(&info, NULL);
+	irq = irq_domain_alloc_irqs(x86_vector_domain, 1, -1, &info);
+	if (irq < 0) {
+		pr_err("Failed to alloc redirected vector for %s's old IRTEs\n",
+			iommu->name);
+		return;
+	}
+
+	/*
+	 * NOTE: we can assign the edge handler here to be shared
+	 * by all irt entries with the same redirected_vector but
+	 * different trigger mode, because edge and level handlers
+	 * behave similarly with disabled irq or no actions.
+	 */
+	irq_set_chip_and_handler(irq, &fake_chip, handle_edge_irq);
+	redirected_vector = irqd_cfg(irq_get_irq_data(irq))->vector;
+
+	pr_info("Redirect %s's old IRTEs to use Vector%u and IRQ%d\n",
+			iommu->name, redirected_vector, irq);
+}
+
+/* Make sure we have a valid vector and irq handler after copy */
+static inline void iommu_assign_old_irte(struct ir_table *new_table,
+			struct irte *old_entry, unsigned int i)
+{
+	struct irte *new_entry = &new_table->base[i];
+
+	if (!old_entry->present)
+		return;
+
+	memcpy(new_entry, old_entry, sizeof(struct irte));
+	if (redirected_vector)
+		new_entry->vector = redirected_vector;
+	bitmap_set(new_table->bitmap, i, 1);
+}
+
 static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
 	struct irte *old_ir_table;
@@ -430,21 +492,17 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	if (!old_ir_table)
 		return -ENOMEM;
 
-	/* Copy data over */
-	memcpy(iommu->ir_table->base, old_ir_table, size);
-
-	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
+	iommu_alloc_redirected_vector(iommu);
 
 	/*
-	 * Now check the table for used entries and mark those as
-	 * allocated in the bitmap
+	 * Copy and adjust old data, and check the table for used entries,
+	 * and mark those as allocated in the bitmap
 	 */
-	for (i = 0; i < INTR_REMAP_TABLE_ENTRIES; i++) {
-		if (iommu->ir_table->base[i].present)
-			bitmap_set(iommu->ir_table->bitmap, i, 1);
-	}
+	for (i = 0; i < INTR_REMAP_TABLE_ENTRIES; i++)
+		iommu_assign_old_irte(iommu->ir_table, &old_ir_table[i], i);
 
 	memunmap(old_ir_table);
+	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
 	return 0;
 }
-- 
2.5.0
