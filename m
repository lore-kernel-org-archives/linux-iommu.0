From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 02/09] iommu/ipmmu-vmsa: Add optional root device feature
Date: Mon, 16 Oct 2017 21:29:36 +0900
Message-ID: <150815697605.32763.17929024813073986910.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Add root device handling to the IPMMU driver by allowing certain
DT compat strings to enable has_cache_leaf_nodes that in turn will
support both root devices with interrupts and leaf devices that
face the actual IPMMU consumer devices.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4: (Many thanks to Robin for feedback)
 - Put the root pointer under struct ipmmu_vmsa_device
 - Drop is_leaf flag
 - Use driver_for_each_device instead of local list of devices
 - Return -EPROBE_DEFER to hook up root device first

 Changes since V3:
 - Reworked root finding code to make it easier to follow, thanks Geert!
 
 Changes since V2:
 - Fixed a bug in ipmmu_find_root() when only leaf devices are present
 - Broke out __ipmmu_find_root() to allow ->xlate() check for root devices

 Changes since V1:
 - Moved patch to earlier in the series
 - Updated code to work with recent changes in:
   [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3

 drivers/iommu/ipmmu-vmsa.c |   90 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 17 deletions(-)

--- 0009/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 19:43:27.020607110 +0900
@@ -36,12 +36,14 @@
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
+	bool has_cache_leaf_nodes;
 };
 
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
 	struct iommu_device iommu;
+	struct ipmmu_vmsa_device *root;
 	const struct ipmmu_features *features;
 	unsigned int num_utlbs;
 	spinlock_t lock;			/* Protects ctx and domains[] */
@@ -199,6 +201,36 @@ static struct ipmmu_vmsa_iommu_priv *to_
 #define IMUASID_ASID0_SHIFT		0
 
 /* -----------------------------------------------------------------------------
+ * Root device handling
+ */
+
+static struct platform_driver ipmmu_driver;
+
+static bool ipmmu_is_root(struct ipmmu_vmsa_device *mmu)
+{
+	return mmu->root == mmu;
+}
+
+static int __ipmmu_check_device(struct device *dev, void *data)
+{
+	struct ipmmu_vmsa_device *mmu = dev_get_drvdata(dev);
+	struct ipmmu_vmsa_device **rootp = data;
+
+	if (ipmmu_is_root(mmu))
+		*rootp = mmu;
+
+	return 0;
+}
+
+static struct ipmmu_vmsa_device *ipmmu_find_root(void)
+{
+	struct ipmmu_vmsa_device *root = NULL;
+
+	return driver_for_each_device(&ipmmu_driver.driver, NULL, &root,
+				      __ipmmu_check_device) == 0 ? root : NULL;
+}
+
+/* -----------------------------------------------------------------------------
  * Read/Write Access
  */
 
@@ -215,13 +247,15 @@ static void ipmmu_write(struct ipmmu_vms
 
 static u32 ipmmu_ctx_read(struct ipmmu_vmsa_domain *domain, unsigned int reg)
 {
-	return ipmmu_read(domain->mmu, domain->context_id * IM_CTX_SIZE + reg);
+	return ipmmu_read(domain->mmu->root,
+			  domain->context_id * IM_CTX_SIZE + reg);
 }
 
 static void ipmmu_ctx_write(struct ipmmu_vmsa_domain *domain, unsigned int reg,
 			    u32 data)
 {
-	ipmmu_write(domain->mmu, domain->context_id * IM_CTX_SIZE + reg, data);
+	ipmmu_write(domain->mmu->root,
+		    domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
 /* -----------------------------------------------------------------------------
@@ -369,12 +403,12 @@ static int ipmmu_domain_init_context(str
 	 * TODO: Add support for coherent walk through CCI with DVM and remove
 	 * cache handling. For now, delegate it to the io-pgtable code.
 	 */
-	domain->cfg.iommu_dev = domain->mmu->dev;
+	domain->cfg.iommu_dev = domain->mmu->root->dev;
 
 	/*
 	 * Find an unused context.
 	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu, domain);
+	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
 	if (ret == IPMMU_CTX_MAX)
 		return -EBUSY;
 
@@ -383,7 +417,8 @@ static int ipmmu_domain_init_context(str
 	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
 					   domain);
 	if (!domain->iop) {
-		ipmmu_domain_free_context(domain->mmu, domain->context_id);
+		ipmmu_domain_free_context(domain->mmu->root,
+					  domain->context_id);
 		return -EINVAL;
 	}
 
@@ -437,7 +472,7 @@ static void ipmmu_domain_destroy_context
 	 */
 	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
-	ipmmu_domain_free_context(domain->mmu, domain->context_id);
+	ipmmu_domain_free_context(domain->mmu->root, domain->context_id);
 }
 
 /* -----------------------------------------------------------------------------
@@ -917,6 +952,7 @@ static void ipmmu_device_reset(struct ip
 
 static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
+	.has_cache_leaf_nodes = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -971,19 +1007,39 @@ static int ipmmu_probe(struct platform_d
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
+	 * Determine if this IPMMU instance is a root device by checking for
+	 * the lack of has_cache_leaf_nodes flag or renesas,ipmmu-main property.
+	 */
+	if (!mmu->features->has_cache_leaf_nodes ||
+	    !of_find_property(pdev->dev.of_node, "renesas,ipmmu-main", NULL))
+		mmu->root = mmu;
+	else
+		mmu->root = ipmmu_find_root();
+
+	/*
+	 * Wait until the root device has been registered for sure.
+	 */
+	if (!mmu->root)
+		return -EPROBE_DEFER;
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
 
 	ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL,
 				     dev_name(&pdev->dev));
