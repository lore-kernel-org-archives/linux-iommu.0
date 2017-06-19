From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 02/09] iommu/ipmmu-vmsa: Add optional root device feature
Date: Mon, 19 Jun 2017 18:14:06 +0900
Message-ID: <149786364660.14868.13384595731879361399.sendpatchset@little-apple>
References: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Add root device handling to the IPMMU driver by allowing certain
DT compat strings to enable has_cache_leaf_nodes that in turn will
support both root devices with interrupts and leaf devices that
face the actual IPMMU consumer devices.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V3:
 - Reworked root finding code to make it easier to follow, thanks Geert!
 
 Changes since V2:
 - Fixed a bug in ipmmu_find_root() when only leaf devices are present
 - Broke out __ipmmu_find_root() to allow ->xlate() check for root devices

 Changes since V1:
 - Moved patch to earlier in the series
 - Updated code to work with recent changes in:
   [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3

 drivers/iommu/ipmmu-vmsa.c |   95 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 17 deletions(-)

--- 0015/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 13:59:41.050607110 +0900
@@ -36,6 +36,7 @@
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
+	bool has_cache_leaf_nodes;
 };
 
 struct ipmmu_vmsa_device {
@@ -44,6 +45,7 @@ struct ipmmu_vmsa_device {
 	struct iommu_device iommu;
 	struct list_head list;
 	const struct ipmmu_features *features;
+	bool is_leaf;
 	unsigned int num_utlbs;
 	spinlock_t lock;			/* Protects ctx and domains[] */
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
@@ -54,6 +56,7 @@ struct ipmmu_vmsa_device {
 
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
+	struct ipmmu_vmsa_device *root;
 	struct iommu_domain io_domain;
 
 	struct io_pgtable_cfg cfg;
@@ -203,6 +206,44 @@ static struct ipmmu_vmsa_iommu_priv *to_
 #define IMUASID_ASID0_SHIFT		0
 
 /* -----------------------------------------------------------------------------
+ * Root device handling
+ */
+
+static bool ipmmu_is_root(struct ipmmu_vmsa_device *mmu)
+{
+	if (mmu->features->has_cache_leaf_nodes)
+		return mmu->is_leaf ? false : true;
+	else
+		return true; /* older IPMMU hardware treated as single root */
+}
+
+static struct ipmmu_vmsa_device *__ipmmu_find_root(void)
+{
+	struct ipmmu_vmsa_device *mmu;
+	struct ipmmu_vmsa_device *root = NULL;
+
+	spin_lock(&ipmmu_devices_lock);
+
+	list_for_each_entry(mmu, &ipmmu_devices, list) {
+		if (ipmmu_is_root(mmu)) {
+			root = mmu;
+			break;
+		}
+	}
+
+	spin_unlock(&ipmmu_devices_lock);
+	return root;
+}
+
+static struct ipmmu_vmsa_device *ipmmu_find_root(struct ipmmu_vmsa_device *leaf)
+{
+	if (ipmmu_is_root(leaf))
+		return leaf;
+	else
+		return __ipmmu_find_root();
+}
+
+/* -----------------------------------------------------------------------------
  * Read/Write Access
  */
 
@@ -219,13 +260,13 @@ static void ipmmu_write(struct ipmmu_vms
 
 static u32 ipmmu_ctx_read(struct ipmmu_vmsa_domain *domain, unsigned int reg)
 {
-	return ipmmu_read(domain->mmu, domain->context_id * IM_CTX_SIZE + reg);
+	return ipmmu_read(domain->root, domain->context_id * IM_CTX_SIZE + reg);
 }
 
 static void ipmmu_ctx_write(struct ipmmu_vmsa_domain *domain, unsigned int reg,
 			    u32 data)
 {
-	ipmmu_write(domain->mmu, domain->context_id * IM_CTX_SIZE + reg, data);
+	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
 /* -----------------------------------------------------------------------------
@@ -360,7 +401,7 @@ static int ipmmu_domain_init_context(str
 	 * TODO: Add support for coherent walk through CCI with DVM and remove
 	 * cache handling. For now, delegate it to the io-pgtable code.
 	 */
-	domain->cfg.iommu_dev = domain->mmu->dev;
+	domain->cfg.iommu_dev = domain->root->dev;
 
 	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
 					   domain);
@@ -370,7 +411,7 @@ static int ipmmu_domain_init_context(str
 	/*
 	 * Find an unused context.
 	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu, domain);
+	ret = ipmmu_domain_allocate_context(domain->root, domain);
 	if (ret == IPMMU_CTX_MAX) {
 		free_io_pgtable_ops(domain->iop);
 		return -EBUSY;
@@ -441,7 +482,7 @@ static void ipmmu_domain_destroy_context
 	 */
 	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
-	ipmmu_domain_free_context(domain->mmu, domain->context_id);
+	ipmmu_domain_free_context(domain->root, domain->context_id);
 }
 
 /* -----------------------------------------------------------------------------
@@ -555,7 +596,7 @@ static int ipmmu_attach_device(struct io
 {
 	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
-	struct ipmmu_vmsa_device *mmu = priv->mmu;
+	struct ipmmu_vmsa_device *root, *mmu = priv->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
@@ -566,11 +607,18 @@ static int ipmmu_attach_device(struct io
 		return -ENXIO;
 	}
 
+	root = ipmmu_find_root(priv->mmu);
+	if (!root) {
+		dev_err(dev, "Unable to locate root IPMMU\n");
+		return -EAGAIN;
+	}
+
 	spin_lock_irqsave(&domain->lock, flags);
 
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
 		domain->mmu = mmu;
+		domain->root = root;
 		ret = ipmmu_domain_init_context(domain);
 	} else if (domain->mmu != mmu) {
 		/*
@@ -911,6 +959,7 @@ static void ipmmu_device_reset(struct ip
 
 static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
+	.has_cache_leaf_nodes = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -965,19 +1014,31 @@ static int ipmmu_probe(struct platform_d
 		mmu->base += IM_NS_ALIAS_OFFSET;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ found\n");
-		return irq;
-	}
 
-	ret = devm_request_irq(&pdev->dev, irq, ipmmu_irq, 0,
-			       dev_name(&pdev->dev), mmu);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ %d\n", irq);
-		return ret;
-	}
+	/*
+	 * Determine if this IPMMU instance is a leaf device by checking
+	 * if the renesas,ipmmu-main property exists or not.
+	 */
+	if (mmu->features->has_cache_leaf_nodes &&
+	    of_find_property(pdev->dev.of_node, "renesas,ipmmu-main", NULL))
+		mmu->is_leaf = true;
+
+	/* Root devices have mandatory IRQs */
+	if (ipmmu_is_root(mmu)) {
+		if (irq < 0) {
+			dev_err(&pdev->dev, "no IRQ found\n");
+			return irq;
+		}
 
-	ipmmu_device_reset(mmu);
+		ret = devm_request_irq(&pdev->dev, irq, ipmmu_irq, 0,
+				       dev_name(&pdev->dev), mmu);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request IRQ %d\n", irq);
+			return ret;
+		}
+
+		ipmmu_device_reset(mmu);
+	}
 
 	ret = iommu_device_register(&mmu->iommu);
 	if (ret)
