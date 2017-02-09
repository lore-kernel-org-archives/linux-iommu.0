From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/11] iommu: Remove iommu_register_instance interface
Date: Thu,  9 Feb 2017 12:33:00 +0100
Message-ID: <1486639981-32368-12-git-send-email-joro@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486639981-32368-1-git-send-email-joro@8bytes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: devicetree@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

And also move its remaining functionality to
iommu_device_register() and 'struct iommu_device'.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu-v3.c  |  2 --
 drivers/iommu/arm-smmu.c     |  1 -
 drivers/iommu/exynos-iommu.c |  2 --
 drivers/iommu/iommu.c        | 37 ++++++-------------------------------
 drivers/iommu/msm_iommu.c    |  2 --
 drivers/iommu/mtk_iommu.c    |  1 -
 include/linux/iommu.h        |  7 -------
 include/linux/of_iommu.h     |  6 ------
 8 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 32133e2..5375137 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2702,8 +2702,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&smmu->iommu);
 
-	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
-
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
 		pci_request_acs();
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f4ce1e7..8fb4af2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2121,7 +2121,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 64325d8..778eccc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -642,8 +642,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
-
 	return 0;
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 21061da..a7e14b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1647,43 +1647,18 @@ int iommu_request_dm_for_dev(struct device *dev)
 	return ret;
 }
 
-struct iommu_instance {
-	struct list_head list;
-	struct fwnode_handle *fwnode;
-	const struct iommu_ops *ops;
-};
-static LIST_HEAD(iommu_instance_list);
-static DEFINE_SPINLOCK(iommu_instance_lock);
-
-void iommu_register_instance(struct fwnode_handle *fwnode,
-			     const struct iommu_ops *ops)
-{
-	struct iommu_instance *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
-
-	if (WARN_ON(!iommu))
-		return;
-
-	of_node_get(to_of_node(fwnode));
-	INIT_LIST_HEAD(&iommu->list);
-	iommu->fwnode = fwnode;
-	iommu->ops = ops;
-	spin_lock(&iommu_instance_lock);
-	list_add_tail(&iommu->list, &iommu_instance_list);
-	spin_unlock(&iommu_instance_lock);
-}
-
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
-	struct iommu_instance *instance;
 	const struct iommu_ops *ops = NULL;
+	struct iommu_device *iommu;
 
-	spin_lock(&iommu_instance_lock);
-	list_for_each_entry(instance, &iommu_instance_list, list)
-		if (instance->fwnode == fwnode) {
-			ops = instance->ops;
+	spin_lock(&iommu_device_lock);
+	list_for_each_entry(iommu, &iommu_device_list, list)
+		if (iommu->fwnode == fwnode) {
+			ops = iommu->ops;
 			break;
 		}
-	spin_unlock(&iommu_instance_lock);
+	spin_unlock(&iommu_device_lock);
 	return ops;
 }
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 30795cb..d044835 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -810,8 +810,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
-
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d484fa6..5d14cd1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -681,7 +681,6 @@ static int mtk_iommu_init_fn(struct device_node *np)
 		return ret;
 	}
 
-	of_iommu_set_ops(np, &mtk_iommu_ops);
 	return 0;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 626c935..9e82fc8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -382,8 +382,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-void iommu_register_instance(struct fwnode_handle *fwnode,
-			     const struct iommu_ops *ops);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 #else /* CONFIG_IOMMU_API */
@@ -634,11 +632,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline void iommu_register_instance(struct fwnode_handle *fwnode,
-					   const struct iommu_ops *ops)
-{
-}
-
 static inline
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 66fcbc9..fc4add3 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,12 +31,6 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-static inline void of_iommu_set_ops(struct device_node *np,
-				    const struct iommu_ops *ops)
-{
-	iommu_register_instance(&np->fwnode, ops);
-}
-
 static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 {
 	return iommu_ops_from_fwnode(&np->fwnode);
-- 
1.9.1
