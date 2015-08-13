From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/9] iommu/vt-d: Access iomem correctly
Date: Thu, 13 Aug 2015 19:33:54 +0200
Message-ID: <1439487236-14098-8-git-send-email-joro@8bytes.org>
References: <1439487236-14098-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439487236-14098-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This fixes wrong accesses to iomem introduced by the kdump
fixing code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c         | 15 +++++++++------
 drivers/iommu/intel_irq_remapping.c |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 93f16aa..a85077d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2799,15 +2799,18 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 }
 
 static int copy_context_table(struct intel_iommu *iommu,
-			      struct root_entry *old_re,
+			      struct root_entry __iomem *old_re,
 			      struct context_entry **tbl,
 			      int bus, bool ext)
 {
-	struct context_entry *old_ce = NULL, *new_ce = NULL, ce;
 	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
+	struct context_entry __iomem *old_ce = NULL;
+	struct context_entry *new_ce = NULL, ce;
+	struct root_entry re;
 	phys_addr_t old_ce_phys;
 
 	tbl_idx = ext ? bus * 2 : bus;
+	memcpy_fromio(&re, old_re, sizeof(re));
 
 	for (devfn = 0; devfn < 256; devfn++) {
 		/* First calculate the correct index */
@@ -2827,9 +2830,9 @@ static int copy_context_table(struct intel_iommu *iommu,
 
 			ret = 0;
 			if (devfn < 0x80)
-				old_ce_phys = root_entry_lctp(old_re);
+				old_ce_phys = root_entry_lctp(&re);
 			else
-				old_ce_phys = root_entry_uctp(old_re);
+				old_ce_phys = root_entry_uctp(&re);
 
 			if (!old_ce_phys) {
 				if (ext && devfn == 0) {
@@ -2854,7 +2857,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 		}
 
 		/* Now copy the context entry */
-		ce = old_ce[idx];
+		memcpy_fromio(&ce, old_ce + idx, sizeof(ce));
 
 		if (!__context_present(&ce))
 			continue;
@@ -2898,8 +2901,8 @@ out:
 
 static int copy_translation_tables(struct intel_iommu *iommu)
 {
+	struct root_entry __iomem *old_rt;
 	struct context_entry **ctxt_tbls;
-	struct root_entry *old_rt;
 	phys_addr_t old_rt_phys;
 	int ctxt_table_entries;
 	unsigned long flags;
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 27cdfa8..9ec4e0d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -384,7 +384,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 
 static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
-	struct irte *old_ir_table;
+	struct irte __iomem *old_ir_table;
 	phys_addr_t irt_phys;
 	unsigned int i;
 	size_t size;
@@ -413,7 +413,7 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 		return -ENOMEM;
 
 	/* Copy data over */
-	memcpy(iommu->ir_table->base, old_ir_table, size);
+	memcpy_fromio(iommu->ir_table->base, old_ir_table, size);
 
 	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
-- 
1.9.1
