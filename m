From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 02/10] iommu/ipmmu-vmsa: Add optional root device feature
Date: Tue, 15 Dec 2015 22:05:27 +0900
Message-ID: <20151215130527.13535.63386.sendpatchset@little-apple>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
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

Add root device handling to the IPMMU driver by
allowing certain DT compat strings to enable
had_cache_leaf_nodes that in turn will support
both root devices with interrupts and leaf devices
that face the actual IPMMU consumer devices.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   86 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 17 deletions(-)

--- 0010/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 21:13:00.440513000 +0900
@@ -33,6 +33,7 @@
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
+	bool has_cache_leaf_nodes;
 };
 
 struct ipmmu_vmsa_device {
@@ -48,10 +49,12 @@ struct ipmmu_vmsa_device {
 	struct dma_iommu_mapping *mapping;
 #endif
 	const struct ipmmu_features *features;
+	bool is_leaf;
 };
 
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
+	struct ipmmu_vmsa_device *root;
 	struct iommu_domain io_domain;
 
 	struct io_pgtable_cfg cfg;
@@ -210,6 +213,36 @@ static void set_dev_data(struct device *
 }
 
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
+static struct ipmmu_vmsa_device *ipmmu_find_root(struct ipmmu_vmsa_device *leaf)
+{
+	struct ipmmu_vmsa_device *mmu;
+
+	if (ipmmu_is_root(leaf))
+		return leaf;
+
+	spin_lock(&ipmmu_devices_lock);
+
+	list_for_each_entry(mmu, &ipmmu_devices, list) {
+		if (ipmmu_is_root(mmu))
+			break;
+	}
+
+	spin_unlock(&ipmmu_devices_lock);
+	return mmu;
+}
+
+/* -----------------------------------------------------------------------------
  * Read/Write Access
  */
 
@@ -226,13 +259,13 @@ static void ipmmu_write(struct ipmmu_vms
 
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
@@ -355,7 +388,7 @@ static int ipmmu_domain_init_context(str
 	 * TODO: Add support for coherent walk through CCI with DVM and remove
 	 * cache handling. For now, delegate it to the io-pgtable code.
 	 */
-	domain->cfg.iommu_dev = domain->mmu->dev;
+	domain->cfg.iommu_dev = domain->root->dev;
 
 	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
 					   domain);
@@ -365,14 +398,14 @@ static int ipmmu_domain_init_context(str
 	/*
 	 * Find an unused context.
 	 */
-	ret = bitmap_find_free_region(domain->mmu->ctx, IPMMU_CTX_MAX, 0);
+	ret = bitmap_find_free_region(domain->root->ctx, IPMMU_CTX_MAX, 0);
 	if (ret < 0) {
 		free_io_pgtable_ops(domain->iop);
 		return ret;
 	}
 
 	domain->context_id = ret;
-	domain->mmu->domains[ret] = domain;
+	domain->root->domains[ret] = domain;
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -532,7 +565,7 @@ static int ipmmu_attach_device(struct io
 			       struct device *dev)
 {
 	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
-	struct ipmmu_vmsa_device *mmu = dev_data->mmu;
+	struct ipmmu_vmsa_device *root, *mmu = dev_data->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	int ret = 0;
@@ -542,11 +575,18 @@ static int ipmmu_attach_device(struct io
 		return -ENXIO;
 	}
 
+	root = ipmmu_find_root(dev_data->mmu);
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
@@ -824,6 +864,7 @@ static void ipmmu_device_reset(struct ip
 
 static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
+	.has_cache_leaf_nodes = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -882,19 +923,30 @@ static int ipmmu_probe(struct platform_d
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
+	 * if an interrupt is availabile or not
+	 */
+	if (mmu->features->has_cache_leaf_nodes && irq < 0)
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
 
 	/*
 	 * We can't create the ARM mapping here as it requires the bus to have
