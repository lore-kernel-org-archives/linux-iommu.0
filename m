From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v11 1/3] ACPI/IORT: Add msi address regions reservation
 helper
Date: Thu, 14 Dec 2017 11:47:59 +0000
Message-ID: <20171214114759.GA27117@e107981-ln.cambridge.arm.com>
References: <20171213115830.61872-1-shameerali.kolothum.thodi@huawei.com>
 <20171213115830.61872-2-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213115830.61872-2-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: robin.murphy@arm.com, marc.zyngier@arm.com, will.deacon@arm.com, joro@8bytes.org, john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 13, 2017 at 11:58:28AM +0000, Shameer Kolothum wrote:
> On some platforms msi parent address regions have to be excluded from
> normal IOVA allocation in that they are detected and decoded in a HW
> specific way by system components and so they cannot be considered normal
> IOVA address space.
> 
> Add a helper function that retrieves ITS address regions - the msi
> parent - through IORT device <-> ITS mappings and reserves it so that
> these regions will not be translated by IOMMU and will be excluded from
> IOVA allocations. The function checks for the smmu model number and
> only applies the msi reservation if the platform requires it.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c        | 112 +++++++++++++++++++++++++++++++++++++--
>  drivers/irqchip/irq-gic-v3-its.c |   3 +-
>  include/linux/acpi_iort.h        |   7 ++-
>  3 files changed, 117 insertions(+), 5 deletions(-)

You need this additional hunk to make it compile on !CONFIG_IOMMU_API:

-- >8 --
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3e0ce652c3e8..e2f7bddf5522 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -762,25 +762,6 @@ static int __maybe_unused __get_pci_rid(struct pci_dev *pdev, u16 alias,
 	return 0;
 }
 
-static __maybe_unused struct acpi_iort_node *iort_get_msi_resv_iommu(
-						struct device *dev)
-{
-	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
-
-	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
-
-	if (iommu && (iommu->type == ACPI_IORT_NODE_SMMU_V3)) {
-		struct acpi_iort_smmu_v3 *smmu;
-
-		smmu = (struct acpi_iort_smmu_v3 *)iommu->node_data;
-		if (smmu->model == ACPI_IORT_SMMU_V3_HISILICON_HI161X)
-			return iommu;
-	}
-
-	return NULL;
-}
-
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 			       struct fwnode_handle *fwnode,
 			       const struct iommu_ops *ops)
@@ -807,6 +788,24 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 }
 
 #ifdef CONFIG_IOMMU_API
+static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
+{
+	struct acpi_iort_node *iommu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+
+	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
+
+	if (iommu && (iommu->type == ACPI_IORT_NODE_SMMU_V3)) {
+		struct acpi_iort_smmu_v3 *smmu;
+
+		smmu = (struct acpi_iort_smmu_v3 *)iommu->node_data;
+		if (smmu->model == ACPI_IORT_SMMU_V3_HISILICON_HI161X)
+			return iommu;
+	}
+
+	return NULL;
+}
+
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(
 				struct iommu_fwspec *fwspec)
 {
