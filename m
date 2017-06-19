From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [patch 11/55] iommu/vt-d: Use named irq domain interface
Date: Tue, 20 Jun 2017 01:37:11 +0200
Message-ID: <20170619235444.063083997@linutronix.de>
References: <20170619233700.547167146@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=iommu-vt-d--Use-named-irq-domain-interface.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
---
 drivers/iommu/intel_irq_remapping.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -500,8 +500,9 @@ static void iommu_enable_irq_remapping(s
 static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 {
 	struct ir_table *ir_table;
-	struct page *pages;
+	struct fwnode_handle *fn;
 	unsigned long *bitmap;
+	struct page *pages;
 
 	if (iommu->ir_table)
 		return 0;
@@ -525,15 +526,24 @@ static int intel_setup_irq_remapping(str
 		goto out_free_pages;
 	}
 
-	iommu->ir_domain = irq_domain_add_hierarchy(arch_get_ir_parent_domain(),
-						    0, INTR_REMAP_TABLE_ENTRIES,
-						    NULL, &intel_ir_domain_ops,
-						    iommu);
+	fn = irq_domain_alloc_named_id_fwnode("INTEL-IR", iommu->seq_id);
+	if (!fn)
+		goto out_free_bitmap;
+
+	iommu->ir_domain =
+		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
+					    0, INTR_REMAP_TABLE_ENTRIES,
+					    fn, &intel_ir_domain_ops,
+					    iommu);
+	kfree(fn);
 	if (!iommu->ir_domain) {
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_bitmap;
 	}
-	iommu->ir_msi_domain = arch_create_msi_irq_domain(iommu->ir_domain);
+	iommu->ir_msi_domain =
+		arch_create_remap_msi_irq_domain(iommu->ir_domain,
+						 "INTEL-IR-MSI",
+						 iommu->seq_id);
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
