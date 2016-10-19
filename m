From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 02/07] iommu/ipmmu-vmsa: Rework interrupt code and use
	bitmap for context
Date: Thu, 20 Oct 2016 08:35:53 +0900
Message-ID: <20161019233553.10506.72700.sendpatchset@little-apple>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161019233533.10506.16810.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce a bitmap for context handing and convert the
interrupt routine to handle all registered contexts.

At this point the number of contexts are still limited.

Also remove the use of the ARM specific mapping variable
from ipmmu_irq() to allow compile on ARM64.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---

 Changes since V5:
 - None

 Changes since V4:
 - None

 Changes since V3:
 - None

 Changes since V2: (Thanks again to Laurent!)
 - Introduce a spinlock together with the bitmap and domain array.
 - Break out code into separate functions for alloc and free.
 - Perform free after (instead of before) configuring hardware registers.
 - Use the spinlock to protect the domain array in the interrupt handler.

 Changes since V1: (Thanks to Laurent for feedback!)
 - Use simple find_first_zero()/set_bit()/clear_bit() for context management.
 - For allocation rely on spinlock held when calling ipmmu_domain_init_context()
 - For test/free use atomic bitops
 - Return IRQ_HANDLED if any of the contexts generated interrupts

 drivers/iommu/ipmmu-vmsa.c |   76 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

--- 0004/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-20 21:48:23.770607110 +0900
@@ -8,6 +8,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -26,12 +27,17 @@
 
 #include "io-pgtable.h"
 
+#define IPMMU_CTX_MAX 1
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
 	struct list_head list;
 
 	unsigned int num_utlbs;
+	spinlock_t lock;			/* Protects ctx and domains[] */
+	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
+	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 
 	struct dma_iommu_mapping *mapping;
 };
@@ -293,9 +299,29 @@ static struct iommu_gather_ops ipmmu_gat
  * Domain/Context Management
  */
 
+static int ipmmu_domain_allocate_context(struct ipmmu_vmsa_device *mmu,
+					 struct ipmmu_vmsa_domain *domain)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&mmu->lock, flags);
+
+	ret = find_first_zero_bit(mmu->ctx, IPMMU_CTX_MAX);
+	if (ret != IPMMU_CTX_MAX) {
+		mmu->domains[ret] = domain;
+		set_bit(ret, mmu->ctx);
+	}
+
+	spin_unlock_irqrestore(&mmu->lock, flags);
+
+	return ret;
+}
+
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
+	int ret;
 
 	/*
 	 * Allocate the page table operations.
@@ -325,10 +351,15 @@ static int ipmmu_domain_init_context(str
 		return -EINVAL;
 
 	/*
-	 * TODO: When adding support for multiple contexts, find an unused
-	 * context.
+	 * Find an unused context.
 	 */
-	domain->context_id = 0;
+	ret = ipmmu_domain_allocate_context(domain->mmu, domain);
+	if (ret == IPMMU_CTX_MAX) {
+		free_io_pgtable_ops(domain->iop);
+		return -EBUSY;
+	}
+
+	domain->context_id = ret;
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -370,6 +401,19 @@ static int ipmmu_domain_init_context(str
 	return 0;
 }
 
+static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
+				      unsigned int context_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mmu->lock, flags);
+
+	clear_bit(context_id, mmu->ctx);
+	mmu->domains[context_id] = NULL;
+
+	spin_unlock_irqrestore(&mmu->lock, flags);
+}
+
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
 	/*
@@ -380,6 +424,7 @@ static void ipmmu_domain_destroy_context
 	 */
 	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
+	ipmmu_domain_free_context(domain->mmu, domain->context_id);
 }
 
 /* -----------------------------------------------------------------------------
@@ -437,16 +482,25 @@ static irqreturn_t ipmmu_domain_irq(stru
 static irqreturn_t ipmmu_irq(int irq, void *dev)
 {
 	struct ipmmu_vmsa_device *mmu = dev;
-	struct iommu_domain *io_domain;
-	struct ipmmu_vmsa_domain *domain;
+	irqreturn_t status = IRQ_NONE;
+	unsigned int i;
+	unsigned long flags;
 
-	if (!mmu->mapping)
-		return IRQ_NONE;
+	spin_lock_irqsave(&mmu->lock, flags);
+
+	/*
+	 * Check interrupts for all active contexts.
+	 */
+	for (i = 0; i < IPMMU_CTX_MAX; i++) {
+		if (!mmu->domains[i])
+			continue;
+		if (ipmmu_domain_irq(mmu->domains[i]) == IRQ_HANDLED)
+			status = IRQ_HANDLED;
+	}
 
-	io_domain = mmu->mapping->domain;
-	domain = to_vmsa_domain(io_domain);
+	spin_unlock_irqrestore(&mmu->lock, flags);
 
-	return ipmmu_domain_irq(domain);
+	return status;
 }
 
 /* -----------------------------------------------------------------------------
@@ -774,6 +828,8 @@ static int ipmmu_probe(struct platform_d
 
 	mmu->dev = &pdev->dev;
 	mmu->num_utlbs = 32;
+	spin_lock_init(&mmu->lock);
+	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
