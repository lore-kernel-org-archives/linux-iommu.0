From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v8 12/16] drivers: iommu: arm-smmu: split probe functions into
	DT/generic portions
Date: Wed, 16 Nov 2016 15:29:32 +0000
Message-ID: <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161116152936.22955-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Current ARM SMMU probe functions intermingle HW and DT probing
in the initialization functions to detect and programme the ARM SMMU
driver features. In order to allow probing the ARM SMMU with other
firmwares than DT, this patch splits the ARM SMMU init functions into
DT and HW specific portions so that other FW interfaces (ie ACPI) can
reuse the HW probing functions and skip the DT portion accordingly.

This patch implements no functional change, only code reshuffling.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 62 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 339a8d3..573b2b6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1668,7 +1668,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
-	bool cttw_dt, cttw_reg;
+	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
 	int i;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
@@ -1713,20 +1713,17 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/*
 	 * In order for DMA API calls to work properly, we must defer to what
-	 * the DT says about coherency, regardless of what the hardware claims.
+	 * the FW says about coherency, regardless of what the hardware claims.
 	 * Fortunately, this also opens up a workaround for systems where the
 	 * ID register value has ended up configured incorrectly.
 	 */
-	cttw_dt = of_dma_is_coherent(smmu->dev->of_node);
 	cttw_reg = !!(id & ID0_CTTW);
-	if (cttw_dt)
-		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
-	if (cttw_dt || cttw_reg)
+	if (cttw_fw || cttw_reg)
 		dev_notice(smmu->dev, "\t%scoherent table walk\n",
-			   cttw_dt ? "" : "non-");
-	if (cttw_dt != cttw_reg)
+			   cttw_fw ? "" : "non-");
+	if (cttw_fw != cttw_reg)
 		dev_notice(smmu->dev,
-			   "\t(IDR0.CTTW overridden by dma-coherent property)\n");
+			   "\t(IDR0.CTTW overridden by FW configuration)\n");
 
 	/* Max. number of entries we have for stream matching/indexing */
 	size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
@@ -1907,15 +1904,25 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
 {
 	const struct arm_smmu_match_data *data;
-	struct resource *res;
-	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	int num_irqs, i, err;
 	bool legacy_binding;
 
+	if (of_property_read_u32(dev->of_node, "#global-interrupts",
+				 &smmu->num_global_irqs)) {
+		dev_err(dev, "missing #global-interrupts property\n");
+		return -ENODEV;
+	}
+
+	data = of_device_get_match_data(dev);
+	smmu->version = data->version;
+	smmu->model = data->model;
+
+	parse_driver_options(smmu);
+
 	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
 	if (legacy_binding && !using_generic_binding) {
 		if (!using_legacy_binding)
@@ -1928,6 +1935,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_dma_is_coherent(dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	return 0;
+}
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	int num_irqs, i, err;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
@@ -1935,9 +1955,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
-	data = of_device_get_match_data(dev);
-	smmu->version = data->version;
-	smmu->model = data->model;
+	err = arm_smmu_device_dt_probe(pdev, smmu);
+	if (err)
+		return err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
@@ -1945,12 +1965,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu->base);
 	smmu->size = resource_size(res);
 
-	if (of_property_read_u32(dev->of_node, "#global-interrupts",
-				 &smmu->num_global_irqs)) {
-		dev_err(dev, "missing #global-interrupts property\n");
-		return -ENODEV;
-	}
-
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
 		num_irqs++;
@@ -1985,8 +1999,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	parse_driver_options(smmu);
-
 	if (smmu->version == ARM_SMMU_V2 &&
 	    smmu->num_context_banks != smmu->num_context_irqs) {
 		dev_err(dev,
@@ -2048,7 +2060,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
 
-- 
2.10.0
