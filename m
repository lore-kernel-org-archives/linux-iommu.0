From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Tue, 4 Jul 2017 18:38:21 +0100
Message-ID: <20170704173820.GO22175@arm.com>
References: <20170623145801.325244-1-shameerali.kolothum.thodi@huawei.com>
 <20170623145801.325244-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170623145801.325244-3-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>
Cc: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org, gabriele.paoloni@huawei.com, john.garry@huawei.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, wangzhou1@hisilicon.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 23, 2017 at 03:58:01PM +0100, shameer wrote:
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
>  drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index abe4b88..c9346f2 100644
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
> @@ -1904,14 +1905,34 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
>  	struct iommu_resv_region *region;
> +	struct arm_smmu_device *smmu;
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +	int resv = 0;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI);
> -	if (!region)
> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);

Does this callback actually get called without a prior ->add_device callback
for the master in question? If not, then we can already claw the structure
out via the iommu_priv field in the fwspec.

> +	if (WARN_ON(!smmu))

Again, how does this trigger?

>  		return;
>  
> -	list_add_tail(&region->list, head);
> +	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
> +
> +		if (!is_of_node(smmu->dev->fwnode))
> +			resv = iort_iommu_its_get_resv_regions(dev, head);

How does this work when we're not using ACPI? Shouldn't of vs ACPI be
abstracted from the driver?

Will
