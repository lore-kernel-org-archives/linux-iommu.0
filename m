From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
Date: Wed, 31 May 2017 15:32:13 +0100
Message-ID: <20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
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

The HW ITS address region associated with the dev is retrieved
using a new helper function added in the IORT code.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 49 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index abe4b88..3767526 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -597,6 +597,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1755,6 +1756,38 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 
 static struct iommu_ops arm_smmu_ops;
 
+#ifdef CONFIG_ACPI
+static struct iommu_resv_region *arm_smmu_acpi_alloc_hw_msi(struct device *dev)
+{
+	struct iommu_resv_region *region;
+	struct	irq_domain *irq_dom;
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	u64	base;
+
+	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
+	if (irq_dom) {
+		int	ret;
+		u32	rid;
+
+		rid = pci_msi_domain_get_msi_rid(irq_dom, to_pci_dev(dev));
+		ret = iort_dev_find_its_base(dev, rid, 0, &base);
+		if (!ret) {
+			dev_info(dev, "SMMUv3:HW MSI resv addr 0x%pa\n", &base);
+			region = iommu_alloc_resv_region(base, SZ_128K,
+							 prot, IOMMU_RESV_MSI);
+			return region;
+		}
+	}
+
+	return NULL;
+}
+#else
+static struct iommu_resv_region *arm_smmu_acpi_alloc_hw_msi(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
@@ -1903,11 +1936,20 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	struct iommu_resv_region *region;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_resv_region *region = NULL;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct arm_smmu_device *smmu;
+
+	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
+	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
+		      dev_is_pci(dev))
+		region = arm_smmu_acpi_alloc_hw_msi(dev);
+
+	if (!region)
+		region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+						 prot, IOMMU_RESV_SW_MSI);
 	if (!region)
 		return;
 
@@ -2611,6 +2653,7 @@ static void parse_driver_acpi_options(struct acpi_iort_smmu_v3 *iort_smmu,
 	switch (iort_smmu->model) {
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
 		break;
 	default:
 		break;
-- 
1.9.1


