From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Tue, 20 Jun 2017 11:29:06 +0100
Message-ID: <20170620102906.GA26908@red-moon>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
 <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>
Cc: marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org, gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Shameer,

On Mon, Jun 19, 2017 at 04:45:00PM +0100, shameer wrote:
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
> +		      dev_is_pci(dev)) {

IORT changes are fine to me, I am still no big fan of this supposedly
generic option that is _really_ platform specific (in particular as I
said before the quirk depends on the PCI host bridge but in this
patchset I see no such dependency. In short - the quirk is hooked off
the SMMUv3 model which implicitly implies a PCI host bridge
configuration IIUC). It is Will and Robin decision though, I am not sure
you can make it any tidier (given that on ACPI you may not even have
a PCI host bridge specific _HID to base your check above on).

Thanks,
Lorenzo

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
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
