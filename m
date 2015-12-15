From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/06] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap
	for context
Date: Tue, 15 Dec 2015 21:02:49 +0900
Message-ID: <20151215120249.26216.25148.sendpatchset@little-apple>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215120212.26216.61530.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce a bitmap for context handing and convert the
interrupt routine to go handle all registered contexts.

At this point the number of contexts are still limited.

The purpose of this patch is to remove the use of the
ARM specific mapping variable from ipmmu_irq(). 

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

--- 0007/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:14:35.540513000 +0900
@@ -8,6 +8,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -26,12 +27,16 @@
 
 #include "io-pgtable.h"
 
+#define IPMMU_CTX_MAX 1
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
 	struct list_head list;
 
 	unsigned int num_utlbs;
+	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
+	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 
 	struct dma_iommu_mapping *mapping;
 };
@@ -319,6 +324,7 @@ static struct iommu_gather_ops ipmmu_gat
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	phys_addr_t ttbr;
+	int ret;
 
 	/*
 	 * Allocate the page table operations.
@@ -348,10 +354,16 @@ static int ipmmu_domain_init_context(str
 		return -EINVAL;
 
 	/*
-	 * TODO: When adding support for multiple contexts, find an unused
-	 * context.
+	 * Find an unused context.
 	 */
-	domain->context_id = 0;
+	ret = bitmap_find_free_region(domain->mmu->ctx, IPMMU_CTX_MAX, 0);
+	if (ret < 0) {
+		free_io_pgtable_ops(domain->iop);
+		return ret;
+	}
+
+	domain->context_id = ret;
+	domain->mmu->domains[ret] = domain;
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -395,6 +407,8 @@ static int ipmmu_domain_init_context(str
 
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
+	bitmap_release_region(domain->mmu->ctx, domain->context_id, 0);
+
 	/*
 	 * Disable the context. Flush the TLB as required when modifying the
 	 * context registers.
@@ -460,16 +474,16 @@ static irqreturn_t ipmmu_domain_irq(stru
 static irqreturn_t ipmmu_irq(int irq, void *dev)
 {
 	struct ipmmu_vmsa_device *mmu = dev;
-	struct iommu_domain *io_domain;
-	struct ipmmu_vmsa_domain *domain;
-
-	if (!mmu->mapping)
-		return IRQ_NONE;
+	irqreturn_t status = IRQ_NONE;
+	unsigned int k;
 
-	io_domain = mmu->mapping->domain;
-	domain = to_vmsa_domain(io_domain);
+	/* Check interrupts for all active contexts */
+	for (k = find_first_bit(mmu->ctx, IPMMU_CTX_MAX);
+	     k < IPMMU_CTX_MAX && status == IRQ_NONE;
+	     k = find_next_bit(mmu->ctx, IPMMU_CTX_MAX, k))
+		status = ipmmu_domain_irq(mmu->domains[k]);
 
-	return ipmmu_domain_irq(domain);
+	return status;
 }
 
 /* -----------------------------------------------------------------------------
@@ -788,6 +802,7 @@ static int ipmmu_probe(struct platform_d
 
 	mmu->dev = &pdev->dev;
 	mmu->num_utlbs = 32;
+	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
