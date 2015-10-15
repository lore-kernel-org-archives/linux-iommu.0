From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 4/5] iommu/arm-smmu: to backward compatible with probe non-deferral
Date: Thu, 15 Oct 2015 16:30:46 +0800
Message-ID: <1444897847-18040-5-git-send-email-thunder.leizhen@huawei.com>
References: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This patch eliminate the strong dependence on Laurent's series(to support
probe deferral). That means, no matter whether Laurent's series upstreamed
or not, the smmu-v3 driver will always work well.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 021a846..66052e9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1857,6 +1857,12 @@ static int arm_smmu_add_device(struct device *dev)
 	struct pci_dev *pdev;
 	struct device *root;

+	if (dev->archdata.iommu == ERR_PTR(-EPROBE_DEFER)) {
+		dev->archdata.iommu = NULL;
+
+		return of_iommu_configure(dev, dev->of_node) ? 0 : -ENODEV;
+	}
+
 	/* only support pci devices hotplug */
 	if (!dev_is_pci(dev))
 		return -ENODEV;
@@ -1930,6 +1936,11 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;

 	smmu = platform_get_drvdata(pdev);
+	if (!smmu) {
+		dev->archdata.iommu = ERR_PTR(-EPROBE_DEFER);
+
+		return -EPROBE_DEFER;
+	}

 	if (!dev->archdata.iommu)
 		dev->archdata.iommu = smmu;
@@ -2768,7 +2779,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)

 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
-	of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);

 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
@@ -2840,7 +2850,13 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);

-IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", NULL);
+static int arm_smmu_of_iommu_init(struct device_node *np)
+{
+	of_iommu_set_ops(np, &arm_smmu_ops);
+
+	return 0;
+}
+IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", arm_smmu_of_iommu_init);

 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
--
2.5.0
