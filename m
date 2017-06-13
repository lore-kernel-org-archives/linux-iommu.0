From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
Date: Tue, 13 Jun 2017 12:48:29 +0100
Message-ID: <20170613114829.188036-3-shameerali.kolothum.thodi@huawei.com>
References: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, shameer <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The HiSilicon erratum 161010801 describes the limitation of HiSilicon
platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.

On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch implements a ACPI table based quirk to reserve the hw msi
regions in the smmu-v3 driver which means these address regions will
not be translated and will be excluded from iova allocations.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index abe4b88..2636c85 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -597,6 +597,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1904,14 +1905,29 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
 	struct iommu_resv_region *region;
+	struct arm_smmu_device *smmu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
-	if (!region)
-		return;
+	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 
-	list_add_tail(&region->list, head);
+	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
+		      dev_is_pci(dev)) {
+		int ret;
+
+		ret = iort_iommu_its_get_resv_regions(dev, head);
+		if (ret) {
+			dev_warn(dev, "HW MSI region reserve failed\n");
+			return;
+		}
+	} else {
+		region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+						 prot, IOMMU_RESV_SW_MSI);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
 
 	iommu_dma_get_resv_regions(dev, head);
 }
@@ -2611,6 +2627,7 @@ static void parse_driver_acpi_options(struct acpi_iort_smmu_v3 *iort_smmu,
 	switch (iort_smmu->model) {
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
 		break;
 	default:
 		break;
-- 
1.9.1


