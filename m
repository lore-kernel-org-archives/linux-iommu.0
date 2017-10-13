From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/4] iommu/ipmmu-vmsa: Simplify group allocation
Date: Fri, 13 Oct 2017 19:23:40 +0100
Message-ID: <c3abc3bea25735556b5c24aaf29edf919d52fc75.1507918320.git.robin.murphy@arm.com>
References: <cover.1507918320.git.robin.murphy@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1507918320.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, arnd@arndb.de, laurent.pinchart+renesas@ideasonboard.com, magnus.damm@gmail.com, geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We go through quite the merry dance in order to find masters behind the
same IPMMU instance, so that we can ensure they are grouped together.
None of which is really necessary, since the master's private data
already points to the particular IPMMU it is associated with, and that
IPMMU instance data is the perfect place to keep track of a per-instance
group directly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 53 ++++++++--------------------------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index dedb386fa81d..d8c9bd4dc657 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -43,6 +43,7 @@ struct ipmmu_vmsa_device {
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 
+	struct iommu_group *group;
 	struct dma_iommu_mapping *mapping;
 };
 
@@ -59,8 +60,6 @@ struct ipmmu_vmsa_domain {
 
 struct ipmmu_vmsa_iommu_priv {
 	struct ipmmu_vmsa_device *mmu;
-	struct device *dev;
-	struct list_head list;
 };
 
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
@@ -674,7 +673,6 @@ static int ipmmu_init_platform_device(struct device *dev,
 		return -ENOMEM;
 
 	priv->mmu = platform_get_drvdata(ipmmu_pdev);
-	priv->dev = dev;
 	dev->iommu_fwspec->iommu_priv = priv;
 	return 0;
 }
@@ -790,9 +788,6 @@ static const struct iommu_ops ipmmu_ops = {
 
 #ifdef CONFIG_IOMMU_DMA
 
-static DEFINE_SPINLOCK(ipmmu_slave_devices_lock);
-static LIST_HEAD(ipmmu_slave_devices);
-
 static int ipmmu_add_device_dma(struct device *dev)
 {
 	struct iommu_group *group;
@@ -807,55 +802,25 @@ static int ipmmu_add_device_dma(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	spin_lock(&ipmmu_slave_devices_lock);
-	list_add(&to_priv(dev)->list, &ipmmu_slave_devices);
-	spin_unlock(&ipmmu_slave_devices_lock);
 	return 0;
 }
 
 static void ipmmu_remove_device_dma(struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
-
-	spin_lock(&ipmmu_slave_devices_lock);
-	list_del(&priv->list);
-	spin_unlock(&ipmmu_slave_devices_lock);
-
 	iommu_group_remove_device(dev);
 }
 
-static struct device *ipmmu_find_sibling_device(struct device *dev)
+static struct iommu_group *ipmmu_find_group(struct device *dev)
 {
 	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
-	struct ipmmu_vmsa_iommu_priv *sibling_priv = NULL;
-	bool found = false;
-
-	spin_lock(&ipmmu_slave_devices_lock);
-
-	list_for_each_entry(sibling_priv, &ipmmu_slave_devices, list) {
-		if (priv == sibling_priv)
-			continue;
-		if (sibling_priv->mmu == priv->mmu) {
-			found = true;
-			break;
-		}
-	}
-
-	spin_unlock(&ipmmu_slave_devices_lock);
-
-	return found ? sibling_priv->dev : NULL;
-}
-
-static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
-{
 	struct iommu_group *group;
-	struct device *sibling;
 
-	sibling = ipmmu_find_sibling_device(dev);
-	if (sibling)
-		group = iommu_group_get(sibling);
-	if (!sibling || IS_ERR(group))
-		group = generic_device_group(dev);
+	if (priv->mmu->group)
+		return iommu_group_ref_get(priv->mmu->group);
+
+	group = iommu_group_alloc();
+	if (!IS_ERR(group))
+		priv->mmu->group = group;
 
 	return group;
 }
@@ -873,7 +838,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device_dma,
 	.remove_device = ipmmu_remove_device_dma,
-	.device_group = ipmmu_find_group_dma,
+	.device_group = ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 };
-- 
2.13.4.dirty
