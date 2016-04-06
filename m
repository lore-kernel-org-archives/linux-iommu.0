From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 3/5] iommu/msm: Add support for generic master bindings
Date: Wed,  6 Apr 2016 19:59:33 +0530
Message-ID: <1459952975-1250-4-git-send-email-sricharan@codeaurora.org>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, Will.Deacon@arm.com, stepanm@codeaurora.org, treding@nvidia.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

This adds the xlate callback which gets invoked during
device registration from DT. The master devices gets added
through this.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/msm_iommu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0f83b85..69e6409 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of_iommu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sizes.h>
@@ -702,6 +703,47 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
 }
 
+static void insert_iommu_master(struct device *dev,
+				struct msm_iommu_dev *iommu,
+				struct of_phandle_args *spec)
+{
+	struct msm_iommu_ctx_dev *master;
+	int sid;
+
+	master = kzalloc(sizeof(*master), GFP_ATOMIC);
+	master->of_node = dev->of_node;
+	list_add(&master->list, &iommu->ctx_list);
+
+	for (sid = 0; sid < spec->args_count; sid++)
+		master->mids[sid] = spec->args[sid];
+
+	master->num_mids = spec->args_count;
+}
+
+static int qcom_iommu_of_xlate(struct device *dev,
+			       struct of_phandle_args *spec)
+{
+	struct msm_iommu_dev *iommu;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&msm_iommu_lock, flags);
+	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
+		if (iommu->dev->of_node == spec->np)
+			break;
+
+	if (!iommu || iommu->dev->of_node != spec->np) {
+		ret = -ENODEV;
+		goto fail;
+	}
+	
+	insert_iommu_master(dev, iommu, spec);
+fail:
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
+	return ret;
+}
+
 irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 {
 	struct msm_iommu_dev *iommu = dev_id;
@@ -737,7 +779,7 @@ fail:
 	return 0;
 }
 
-static const struct iommu_ops msm_iommu_ops = {
+static struct iommu_ops msm_iommu_ops = {
 	.capable = msm_iommu_capable,
 	.domain_alloc = msm_iommu_domain_alloc,
 	.domain_free = msm_iommu_domain_free,
@@ -748,6 +790,7 @@ static const struct iommu_ops msm_iommu_ops = {
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
+	.of_xlate = qcom_iommu_of_xlate,
 };
 
 static int msm_iommu_probe(struct platform_device *pdev)
@@ -837,6 +880,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
+	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
@@ -935,7 +979,13 @@ static int __init msm_iommu_init(void)
 	return 0;
 }
 
-subsys_initcall(msm_iommu_init);
+static int __init msm_iommu_of_setup(struct device_node *np)
+{
+	msm_iommu_init();
+	return 0;
+}
+
+IOMMU_OF_DECLARE(msm_iommu_of, "qcom,iommu-v0", msm_iommu_of_setup);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stepan Moskovchenko <stepanm@codeaurora.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
