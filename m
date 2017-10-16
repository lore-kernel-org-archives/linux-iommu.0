From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 03/09] iommu/ipmmu-vmsa: Enable multi context support
Date: Mon, 16 Oct 2017 21:29:46 +0900
Message-ID: <150815698669.32763.16753019201670130250.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Add support for up to 8 contexts. Each context is mapped to one
domain. One domain is assigned one or more slave devices. Contexts
are allocated dynamically and slave devices are grouped together
based on which IPMMU device they are connected to. This makes slave
devices tied to the same IPMMU device share the same IOVA space.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - None

 Changes since V3:
 - Use number_of_contexts unsigned int, drop WARN_ON() - Thanks Robin!

 Changes since V2:
 - Updated patch description to reflect code included in:
   [PATCH v7 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V7

 Changes since V1:
 - Support up to 8 contexts instead of 4
 - Use feature flag and runtime handling
 - Default to single context

 drivers/iommu/ipmmu-vmsa.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- 0011/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 19:46:09.900607110 +0900
@@ -32,11 +32,12 @@
 
 #include "io-pgtable.h"
 
-#define IPMMU_CTX_MAX 1
+#define IPMMU_CTX_MAX 8
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
+	unsigned int number_of_contexts;
 };
 
 struct ipmmu_vmsa_device {
@@ -46,6 +47,7 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_device *root;
 	const struct ipmmu_features *features;
 	unsigned int num_utlbs;
+	unsigned int num_ctx;
 	spinlock_t lock;			/* Protects ctx and domains[] */
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
@@ -352,11 +354,12 @@ static int ipmmu_domain_allocate_context
 
 	spin_lock_irqsave(&mmu->lock, flags);
 
-	ret = find_first_zero_bit(mmu->ctx, IPMMU_CTX_MAX);
-	if (ret != IPMMU_CTX_MAX) {
+	ret = find_first_zero_bit(mmu->ctx, mmu->num_ctx);
+	if (ret != mmu->num_ctx) {
 		mmu->domains[ret] = domain;
 		set_bit(ret, mmu->ctx);
-	}
+	} else
+		ret = -EBUSY;
 
 	spin_unlock_irqrestore(&mmu->lock, flags);
 
@@ -409,8 +412,8 @@ static int ipmmu_domain_init_context(str
 	 * Find an unused context.
 	 */
 	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret == IPMMU_CTX_MAX)
-		return -EBUSY;
+	if (ret < 0)
+		return ret;
 
 	domain->context_id = ret;
 
@@ -539,7 +542,7 @@ static irqreturn_t ipmmu_irq(int irq, vo
 	/*
 	 * Check interrupts for all active contexts.
 	 */
-	for (i = 0; i < IPMMU_CTX_MAX; i++) {
+	for (i = 0; i < mmu->num_ctx; i++) {
 		if (!mmu->domains[i])
 			continue;
 		if (ipmmu_domain_irq(mmu->domains[i]) == IRQ_HANDLED)
@@ -603,6 +606,13 @@ static int ipmmu_attach_device(struct io
 		/* The domain hasn't been used yet, initialize it. */
 		domain->mmu = mmu;
 		ret = ipmmu_domain_init_context(domain);
+		if (ret < 0) {
+			dev_err(dev, "Unable to initialize IPMMU context\n");
+			domain->mmu = NULL;
+		} else {
+			dev_info(dev, "Using IPMMU context %u\n",
+				 domain->context_id);
+		}
 	} else if (domain->mmu != mmu) {
 		/*
 		 * Something is wrong, we can't attach two devices using
@@ -946,13 +956,14 @@ static void ipmmu_device_reset(struct ip
 	unsigned int i;
 
 	/* Disable all contexts. */
-	for (i = 0; i < 4; ++i)
+	for (i = 0; i < mmu->num_ctx; ++i)
 		ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
 }
 
 static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
+	.number_of_contexts = 1, /* software only tested with one context */
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -1006,6 +1017,9 @@ static int ipmmu_probe(struct platform_d
 	if (mmu->features->use_ns_alias_offset)
 		mmu->base += IM_NS_ALIAS_OFFSET;
 
+	mmu->num_ctx = min_t(unsigned int, IPMMU_CTX_MAX,
+			     mmu->features->number_of_contexts);
+
 	irq = platform_get_irq(pdev, 0);
 
 	/*
