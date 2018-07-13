From: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCH 2/3] iommu/arm-smmu: Add optional SMMU clock
Date: Fri, 13 Jul 2018 11:27:57 -0500
Message-ID: <1531499278-32132-3-git-send-email-thor.thayer@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1531499278-32132-1-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Add a clock to the SMMU structure. In the device tree case,
check for a clock handle and enable the clock if found.

Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..0e6dd5019c23 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -212,6 +212,7 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+	struct clk			*clk;
 };
 
 enum arm_smmu_context_fmt {
@@ -1992,6 +1993,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
 
+	/* If a clock is declared, enable it */
+	smmu->clk = devm_clk_get(smmu->dev, NULL);
+	if (IS_ERR(smmu->clk)) {
+		smmu->clk = NULL;
+		dev_dbg(dev, "cannot get smmu clock\n");
+	} else {
+		clk_prepare_enable(smmu->clk);
+	}
+
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
 		dev_err(dev, "missing #global-interrupts property\n");
@@ -2181,6 +2191,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	if (smmu->clk)
+		clk_disable_unprepare(smmu->clk);
+
 	return 0;
 }
 
@@ -2193,6 +2207,9 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
+	if (smmu->clk)
+		clk_prepare_enable(smmu->clk);
+
 	arm_smmu_device_reset(smmu);
 	return 0;
 }
-- 
2.7.4
