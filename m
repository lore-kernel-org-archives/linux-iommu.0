From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Mon, 19 Jun 2017 18:41:49 +0100
Message-ID: <311de3aa-aec9-f403-d9a8-48b3e3de54c3@arm.com>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
 <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 19/06/17 16:45, shameer wrote:
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.
> 
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the
> MSI payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch implements a ACPI table based quirk to reserve the hw msi
> regions in the smmu-v3 driver which means these address regions will
> not be translated and will be excluded from iova allocations.
> 
> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index abe4b88..f03c63b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -597,6 +597,7 @@ struct arm_smmu_device {
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> @@ -1904,14 +1905,31 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
>  	struct iommu_resv_region *region;
> +	struct arm_smmu_device *smmu;
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI);
> -	if (!region)
> -		return;
> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> +
> +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&

AFAICS, iommu_get_resv_regions is only ever called on devices which are
at least already part of an iommu_group, so smmu should never
legitimately be NULL. I'd say if you really want to be robust against
flagrant API misuse, at least WARN_ON and bail out immediately.

Robin.

> +		      dev_is_pci(dev)) {
> +		int ret = -EINVAL;
> +
> +		if (!is_of_node(smmu->dev->fwnode))
> +			ret = iort_iommu_its_get_resv_regions(dev, head);
>  
> -	list_add_tail(&region->list, head);
> +		if (ret) {
> +			dev_warn(dev, "HW MSI region resv failed: %d\n", ret);
> +			return;
> +		}
> +	} else {
> +		region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +						 prot, IOMMU_RESV_SW_MSI);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +	}
>  
>  	iommu_dma_get_resv_regions(dev, head);
>  }
> @@ -2611,6 +2629,7 @@ static void parse_driver_acpi_options(struct acpi_iort_smmu_v3 *iort_smmu,
>  	switch (iort_smmu->model) {
>  	case ACPI_IORT_SMMU_HISILICON_HI161X:
>  		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
> +		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
>  		break;
>  	default:
>  		break;
> 

