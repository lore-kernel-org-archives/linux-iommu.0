From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V4 4/7] iommu/msm: Add support for generic master bindings
Date: Mon, 16 May 2016 12:18:58 +0530
Message-ID: <1463381341-30498-5-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463381341-30498-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This adds the xlate callback which gets invoked during
device registration from DT. The master devices gets added
through this.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/msm_iommu.c | 61 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f532c9f..a90a121 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of_iommu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sizes.h>
@@ -702,6 +703,54 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
 }
 
+static void insert_iommu_master(struct device *dev,
+				struct msm_iommu_dev **iommu,
+				struct of_phandle_args *spec)
+{
+	struct msm_iommu_ctx_dev *master = dev->archdata.iommu;
+	int sid;
+
+	if (list_empty(&(*iommu)->ctx_list)) {
+		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		master->of_node = dev->of_node;
+		list_add(&master->list, &(*iommu)->ctx_list);
+		dev->archdata.iommu = master;
+	}
+
+	for (sid = 0; sid < master->num_mids; sid++)
+		if (master->mids[sid] == spec->args[0]) {
+			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
+				 sid);
+			return;
+		}
+
+	master->mids[master->num_mids++] = spec->args[0];
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
+	insert_iommu_master(dev, &iommu, spec);
+fail:
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
+	return ret;
+}
+
 irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 {
 	struct msm_iommu_dev *iommu = dev_id;
@@ -737,7 +786,7 @@ fail:
 	return 0;
 }
 
-static const struct iommu_ops msm_iommu_ops = {
+static struct iommu_ops msm_iommu_ops = {
 	.capable = msm_iommu_capable,
 	.domain_alloc = msm_iommu_domain_alloc,
 	.domain_free = msm_iommu_domain_free,
@@ -748,6 +797,7 @@ static const struct iommu_ops msm_iommu_ops = {
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
+	.of_xlate = qcom_iommu_of_xlate,
 };
 
 static int msm_iommu_probe(struct platform_device *pdev)
@@ -837,6 +887,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
+	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
@@ -935,7 +986,13 @@ static int __init msm_iommu_init(void)
 	return 0;
 }
 
-subsys_initcall(msm_iommu_init);
+static int __init msm_iommu_of_setup(struct device_node *np)
+{
+	msm_iommu_init();
+	return 0;
+}
+
+IOMMU_OF_DECLARE(msm_iommu_of, "msm,iommu-v0", msm_iommu_of_setup);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
