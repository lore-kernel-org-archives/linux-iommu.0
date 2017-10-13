From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 3/4] iommu/ipmmu-vmsa: Clean up struct ipmmu_vmsa_iommu_priv
Date: Fri, 13 Oct 2017 19:23:41 +0100
Message-ID: <59687825d12d00452aff0f4608a060e57130afdb.1507918320.git.robin.murphy@arm.com>
References: <cover.1507918320.git.robin.murphy@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1507918320.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, arnd@arndb.de, laurent.pinchart+renesas@ideasonboard.com, magnus.damm@gmail.com, geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Now that the IPMMU instance pointer is the only thing remaining in the
private data structure, we no longer need the extra level of indirection
and can simply stash that directlty in the fwspec.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d8c9bd4dc657..4d69c08145a1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -58,16 +58,12 @@ struct ipmmu_vmsa_domain {
 	spinlock_t lock;			/* Protects mappings */
 };
 
-struct ipmmu_vmsa_iommu_priv {
-	struct ipmmu_vmsa_device *mmu;
-};
-
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
-static struct ipmmu_vmsa_iommu_priv *to_priv(struct device *dev)
+static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 {
 	return dev->iommu_fwspec ? dev->iommu_fwspec->iommu_priv : NULL;
 }
@@ -565,15 +561,14 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
-	struct ipmmu_vmsa_device *mmu = priv->mmu;
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
-	if (!priv || !priv->mmu) {
+	if (!mmu) {
 		dev_err(dev, "Cannot attach to IPMMU\n");
 		return -ENXIO;
 	}
@@ -662,18 +657,12 @@ static int ipmmu_init_platform_device(struct device *dev,
 				      struct of_phandle_args *args)
 {
 	struct platform_device *ipmmu_pdev;
-	struct ipmmu_vmsa_iommu_priv *priv;
 
 	ipmmu_pdev = of_find_device_by_node(args->np);
 	if (!ipmmu_pdev)
 		return -ENODEV;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->mmu = platform_get_drvdata(ipmmu_pdev);
-	dev->iommu_fwspec->iommu_priv = priv;
+	dev->iommu_fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
 	return 0;
 }
 
@@ -683,7 +672,7 @@ static int ipmmu_of_xlate(struct device *dev,
 	iommu_fwspec_add_ids(dev, spec->args, 1);
 
 	/* Initialize once - xlate() will call multiple times */
-	if (to_priv(dev))
+	if (to_ipmmu(dev))
 		return 0;
 
 	return ipmmu_init_platform_device(dev, spec);
@@ -693,14 +682,14 @@ static int ipmmu_of_xlate(struct device *dev,
 
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = NULL;
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
 	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_priv(dev))
+	if (!mmu)
 		return -ENODEV;
 
 	/* Create a device group and add the device to it. */
@@ -729,7 +718,6 @@ static int ipmmu_add_device(struct device *dev)
 	 * - Make the mapping size configurable ? We currently use a 2GB mapping
 	 *   at a 1GB offset to ensure that NULL VAs will fault.
 	 */
-	mmu = to_priv(dev)->mmu;
 	if (!mmu->mapping) {
 		struct dma_iommu_mapping *mapping;
 
@@ -795,7 +783,7 @@ static int ipmmu_add_device_dma(struct device *dev)
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_priv(dev))
+	if (!to_ipmmu(dev))
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
@@ -812,15 +800,15 @@ static void ipmmu_remove_device_dma(struct device *dev)
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
 
-	if (priv->mmu->group)
-		return iommu_group_ref_get(priv->mmu->group);
+	if (mmu->group)
+		return iommu_group_ref_get(mmu->group);
 
 	group = iommu_group_alloc();
 	if (!IS_ERR(group))
-		priv->mmu->group = group;
+		mmu->group = group;
 
 	return group;
 }
-- 
2.13.4.dirty
