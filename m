From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V4 3/7] iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
Date: Mon, 16 May 2016 12:18:57 +0530
Message-ID: <1463381341-30498-4-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463381341-30498-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There are only two functions left in msm_iommu_dev.c. Move it to
msm_iommu.c and delete the file.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/Makefile        |   2 +-
 drivers/iommu/msm_iommu.c     | 182 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/msm_iommu_dev.c | 212 ------------------------------------------
 3 files changed, 183 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index e7b64d1..6de2fb1 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
-obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
+obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_QCOM_IOMMU_V1) += qcom/
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index bc1a4e3..f532c9f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sizes.h>
@@ -85,6 +86,47 @@ static void __disable_clocks(struct msm_iommu_dev *iommu)
 	clk_disable(iommu->pclk);
 }
 
+static void msm_iommu_reset(void __iomem *base, int ncb)
+{
+	int ctx;
+
+	SET_RPUE(base, 0);
+	SET_RPUEIE(base, 0);
+	SET_ESRRESTORE(base, 0);
+	SET_TBE(base, 0);
+	SET_CR(base, 0);
+	SET_SPDMBE(base, 0);
+	SET_TESTBUSCR(base, 0);
+	SET_TLBRSW(base, 0);
+	SET_GLOBAL_TLBIALL(base, 0);
+	SET_RPU_ACR(base, 0);
+	SET_TLBLKCRWE(base, 1);
+
+	for (ctx = 0; ctx < ncb; ctx++) {
+		SET_BPRCOSH(base, ctx, 0);
+		SET_BPRCISH(base, ctx, 0);
+		SET_BPRCNSH(base, ctx, 0);
+		SET_BPSHCFG(base, ctx, 0);
+		SET_BPMTCFG(base, ctx, 0);
+		SET_ACTLR(base, ctx, 0);
+		SET_SCTLR(base, ctx, 0);
+		SET_FSRRESTORE(base, ctx, 0);
+		SET_TTBR0(base, ctx, 0);
+		SET_TTBR1(base, ctx, 0);
+		SET_TTBCR(base, ctx, 0);
+		SET_BFBCR(base, ctx, 0);
+		SET_PAR(base, ctx, 0);
+		SET_FAR(base, ctx, 0);
+		SET_CTX_TLBIALL(base, ctx, 0);
+		SET_TLBFLPTER(base, ctx, 0);
+		SET_TLBSLPTER(base, ctx, 0);
+		SET_TLBLKCR(base, ctx, 0);
+		SET_PRRR(base, ctx, 0);
+		SET_NMRR(base, ctx, 0);
+		SET_CONTEXTIDR(base, ctx, 0);
+	}
+}
+
 static int __flush_iotlb(struct iommu_domain *domain)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
@@ -708,6 +750,146 @@ static const struct iommu_ops msm_iommu_ops = {
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 };
 
+static int msm_iommu_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct msm_iommu_dev *iommu;
+	int ret, par, val;
+
+	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return -ENODEV;
+
+	iommu->dev = &pdev->dev;
+	INIT_LIST_HEAD(&iommu->ctx_list);
+
+	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
+	if (IS_ERR(iommu->pclk)) {
+		dev_err(iommu->dev, "could not get smmu_pclk\n");
+		return PTR_ERR(iommu->pclk);
+	}
+
+	ret = clk_prepare(iommu->pclk);
+	if (ret) {
+		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
+		return ret;
+	}
+
+	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
+	if (IS_ERR(iommu->clk)) {
+		dev_err(iommu->dev, "could not get iommu_clk\n");
+		clk_unprepare(iommu->pclk);
+		return PTR_ERR(iommu->clk);
+	}
+
+	ret = clk_prepare(iommu->clk);
+	if (ret) {
+		dev_err(iommu->dev, "could not prepare iommu_clk\n");
+		clk_unprepare(iommu->pclk);
+		return ret;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iommu->base = devm_ioremap_resource(iommu->dev, r);
+	if (IS_ERR(iommu->base)) {
+		dev_err(iommu->dev, "could not get iommu base\n");
+		ret = PTR_ERR(iommu->base);
+		goto fail;
+	}
+
+	iommu->irq = platform_get_irq(pdev, 0);
+	if (iommu->irq < 0) {
+		dev_err(iommu->dev, "could not get iommu irq\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	ret = of_property_read_u32(iommu->dev->of_node, "qcom,ncb", &val);
+	if (ret) {
+		dev_err(iommu->dev, "could not get ncb\n");
+		goto fail;
+	}
+	iommu->ncb = val;
+
+	msm_iommu_reset(iommu->base, iommu->ncb);
+	SET_M(iommu->base, 0, 1);
+	SET_PAR(iommu->base, 0, 0);
+	SET_V2PCFG(iommu->base, 0, 1);
+	SET_V2PPR(iommu->base, 0, 0);
+	par = GET_PAR(iommu->base, 0);
+	SET_V2PCFG(iommu->base, 0, 0);
+	SET_M(iommu->base, 0, 0);
+
+	if (!par) {
+		pr_err("Invalid PAR value detected\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
+					msm_iommu_fault_handler,
+					IRQF_ONESHOT | IRQF_SHARED,
+					"msm_iommu_secure_irpt_handler",
+					iommu);
+	if (ret) {
+		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
+		goto fail;
+	}
+
+	list_add(&iommu->dev_node, &qcom_iommu_devices);
+
+	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
+		iommu->base, iommu->irq, iommu->ncb);
+
+	return ret;
+fail:
+	clk_unprepare(iommu->clk);
+	clk_unprepare(iommu->pclk);
+	return ret;
+}
+
+static const struct of_device_id msm_iommu_dt_match[] = {
+	{ .compatible = "qcom,iommu-v0-apq8064" },
+	{}
+};
+
+static int msm_iommu_remove(struct platform_device *pdev)
+{
+	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
+
+	clk_unprepare(iommu->clk);
+	clk_unprepare(iommu->pclk);
+	return 0;
+}
+
+static struct platform_driver msm_iommu_driver = {
+	.driver = {
+		.name	= "msm_iommu",
+		.of_match_table = msm_iommu_dt_match,
+	},
+	.probe		= msm_iommu_probe,
+	.remove		= msm_iommu_remove,
+};
+
+static int __init msm_iommu_driver_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&msm_iommu_driver);
+	if (ret != 0)
+		pr_err("Failed to register IOMMU driver\n");
+
+	return ret;
+}
+
+static void __exit msm_iommu_driver_exit(void)
+{
+	platform_driver_unregister(&msm_iommu_driver);
+}
+
+subsys_initcall(msm_iommu_driver_init);
+module_exit(msm_iommu_driver_exit);
+
 static int __init get_tex_class(int icp, int ocp, int mt, int nos)
 {
 	int i = 0;
diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
deleted file mode 100644
index 9f1e760..0000000
--- a/drivers/iommu/msm_iommu_dev.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/iommu.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-
-#include "msm_iommu_hw-8xxx.h"
-#include "msm_iommu.h"
-
-static void msm_iommu_reset(void __iomem *base, int ncb)
-{
-	int ctx;
-
-	SET_RPUE(base, 0);
-	SET_RPUEIE(base, 0);
-	SET_ESRRESTORE(base, 0);
-	SET_TBE(base, 0);
-	SET_CR(base, 0);
-	SET_SPDMBE(base, 0);
-	SET_TESTBUSCR(base, 0);
-	SET_TLBRSW(base, 0);
-	SET_GLOBAL_TLBIALL(base, 0);
-	SET_RPU_ACR(base, 0);
-	SET_TLBLKCRWE(base, 1);
-
-	for (ctx = 0; ctx < ncb; ctx++) {
-		SET_BPRCOSH(base, ctx, 0);
-		SET_BPRCISH(base, ctx, 0);
-		SET_BPRCNSH(base, ctx, 0);
-		SET_BPSHCFG(base, ctx, 0);
-		SET_BPMTCFG(base, ctx, 0);
-		SET_ACTLR(base, ctx, 0);
-		SET_SCTLR(base, ctx, 0);
-		SET_FSRRESTORE(base, ctx, 0);
-		SET_TTBR0(base, ctx, 0);
-		SET_TTBR1(base, ctx, 0);
-		SET_TTBCR(base, ctx, 0);
-		SET_BFBCR(base, ctx, 0);
-		SET_PAR(base, ctx, 0);
-		SET_FAR(base, ctx, 0);
-		SET_CTX_TLBIALL(base, ctx, 0);
-		SET_TLBFLPTER(base, ctx, 0);
-		SET_TLBSLPTER(base, ctx, 0);
-		SET_TLBLKCR(base, ctx, 0);
-		SET_PRRR(base, ctx, 0);
-		SET_NMRR(base, ctx, 0);
-		SET_CONTEXTIDR(base, ctx, 0);
-	}
-}
-
-static int msm_iommu_probe(struct platform_device *pdev)
-{
-	struct resource *r;
-	struct msm_iommu_dev *iommu;
-	int ret, par, val;
-
-	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
-	if (!iommu)
-		return -ENODEV;
-
-	iommu->dev = &pdev->dev;
-	INIT_LIST_HEAD(&iommu->ctx_list);
-
-	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
-	if (IS_ERR(iommu->pclk)) {
-		dev_err(iommu->dev, "could not get smmu_pclk\n");
-		return PTR_ERR(iommu->pclk);
-	}
-
-	ret = clk_prepare(iommu->pclk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
-		return ret;
-	}
-
-	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
-	if (IS_ERR(iommu->clk)) {
-		dev_err(iommu->dev, "could not get iommu_clk\n");
-		clk_unprepare(iommu->pclk);
-		return PTR_ERR(iommu->clk);
-	}
-
-	ret = clk_prepare(iommu->clk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare iommu_clk\n");
-		clk_unprepare(iommu->pclk);
-		return ret;
-	}
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iommu->base = devm_ioremap_resource(iommu->dev, r);
-	if (IS_ERR(iommu->base)) {
-		dev_err(iommu->dev, "could not get iommu base\n");
-		ret = PTR_ERR(iommu->base);
-		goto fail;
-	}
-
-	iommu->irq = platform_get_irq(pdev, 0);
-	if (iommu->irq < 0) {
-		dev_err(iommu->dev, "could not get iommu irq\n");
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	ret = of_property_read_u32(iommu->dev->of_node, "ncb", &val);
-	if (ret) {
-		dev_err(iommu->dev, "could not get ncb\n");
-		goto fail;
-	}
-	iommu->ncb = val;
-
-	msm_iommu_reset(iommu->base, iommu->ncb);
-	SET_M(iommu->base, 0, 1);
-	SET_PAR(iommu->base, 0, 0);
-	SET_V2PCFG(iommu->base, 0, 1);
-	SET_V2PPR(iommu->base, 0, 0);
-	par = GET_PAR(iommu->base, 0);
-	SET_V2PCFG(iommu->base, 0, 0);
-	SET_M(iommu->base, 0, 0);
-
-	if (!par) {
-		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
-					msm_iommu_fault_handler,
-					IRQF_ONESHOT | IRQF_SHARED,
-					"msm_iommu_secure_irpt_handler",
-					iommu);
-	if (ret) {
-		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
-	}
-
-	list_add(&iommu->dev_node, &qcom_iommu_devices);
-
-	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
-		iommu->base, iommu->irq, iommu->ncb);
-fail:
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return ret;
-}
-
-static const struct of_device_id msm_iommu_dt_match[] = {
-	{ .compatible = "qcom,iommu-v0-apq8064" },
-	{}
-};
-
-static int msm_iommu_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
-
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return 0;
-}
-
-static struct platform_driver msm_iommu_driver = {
-	.driver = {
-		.name	= "msm_iommu",
-		.of_match_table = msm_iommu_dt_match,
-	},
-	.probe		= msm_iommu_probe,
-	.remove		= msm_iommu_remove,
-};
-
-static struct platform_driver * const drivers[] = {
-	&msm_iommu_driver,
-	&msm_iommu_ctx_driver,
-};
-
-static int __init msm_iommu_driver_init(void)
-{
-	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
-}
-
-static void __exit msm_iommu_driver_exit(void)
-{
-	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
-}
-
-subsys_initcall(msm_iommu_driver_init);
-module_exit(msm_iommu_driver_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
