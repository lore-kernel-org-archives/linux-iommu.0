From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/7] iommu/arm-smmu-v3: Do resource size checks based on
	SMMU
Date: Thu,  4 May 2017 18:05:34 +0530
Message-ID: <1493901339-14929-3-git-send-email-gakula@caviumnetworks.com>
References: <1493901339-14929-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493901339-14929-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

With implementations supporting only page 0 register space,
resource size can be 64k as well and hence perform size checks
based on SMMU option PAGE0_REGS_ONLY.

For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
platform_get_resource call, so that SMMU options are set beforehand.

Signed-off-by:  Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by:  Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 107b4a6..f027676 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2672,6 +2672,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return ret;
 }
 
+static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
+{
+	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return SZ_64K;
+	else
+		return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -2688,9 +2696,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	if (dev->of_node) {
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	} else {
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+		if (ret == -ENODEV)
+			return ret;
+	}
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < SZ_128K) {
+	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
@@ -2717,14 +2733,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
-	}
-
 	/* Set bypass mode according to firmware probing result */
 	bypass = !!ret;
 
-- 
1.8.3.1
