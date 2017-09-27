From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v8 5/5] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
Date: Wed, 27 Sep 2017 14:32:41 +0100
Message-ID: <20170927133241.21036-6-shameerali.kolothum.thodi@huawei.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, mark.rutland@arm.com, robh@kernel.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The HiSilicon erratum 161010801 describes the limitation of HiSilicon
platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.

On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch implements a quirk to reserve the hw msi regions in the
smmu-v3 driver which means these address regions will not be
translated and will be excluded from iova allocations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c..fb7f08d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -413,6 +413,9 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define SMMU_V3_GENERIC_ARM		0x0
+#define SMMU_V3_HISILICON_HI161X	0x1
+
 /* Until ACPICA headers cover IORT rev. C */
 #ifndef ACPI_IORT_SMMU_HISILICON_HI161X
 #define ACPI_IORT_SMMU_HISILICON_HI161X		0x1
@@ -608,6 +611,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
+#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 2)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -696,6 +700,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
+	const void *data = of_device_get_match_data(smmu->dev);
+	u32 model = *(u32 *)&data;
 
 	do {
 		if (of_property_read_bool(smmu->dev->of_node,
@@ -705,6 +711,11 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 				arm_smmu_options[i].prop);
 		}
 	} while (arm_smmu_options[++i].opt);
+
+	if (model == SMMU_V3_HISILICON_HI161X) {
+		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
+		dev_notice(smmu->dev, "\tenabling workaround for HiSilicon erratum 161010801\n");
+	}
 }
 
 /* Low-level queue manipulation functions */
@@ -1934,14 +1945,29 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
 	struct iommu_resv_region *region;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct arm_smmu_device *smmu = master->smmu;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	int resv = 0;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
-	if (!region)
-		return;
+	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
 
-	list_add_tail(&region->list, head);
+		resv = iommu_dma_get_msi_resv_regions(dev, head);
+
+		if (resv < 0) {
+			dev_warn(dev, "HW MSI region resv failed: %d\n", resv);
+			return;
+		}
+	}
+
+	if (!resv) {
+		region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+						 prot, IOMMU_RESV_SW_MSI);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
 
 	iommu_dma_get_resv_regions(dev, head);
 }
@@ -2667,6 +2693,7 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 		break;
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
 		break;
 	}
 
@@ -2862,7 +2889,9 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
-	{ .compatible = "arm,smmu-v3", },
+	{ .compatible = "hisilicon,hi161x-smmu-v3",
+			.data = (void *)SMMU_V3_HISILICON_HI161X },
+	{ .compatible = "arm,smmu-v3", .data = (void *)SMMU_V3_GENERIC_ARM },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
1.9.1


