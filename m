From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Fri, 4 Nov 2016 14:16:04 +0000
Message-ID: <f6f93736-a3bb-5eb7-bb0f-afde21f98098@arm.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

On 04/11/16 11:24, Eric Auger wrote:
> The function populates the list of reserved regions with the
> PCI host bridge windows and the MSI IOVA range.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> RFC v1 -> v2: use defines for MSI IOVA base and length
> ---
>  drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c841eb7..c07ea41 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -278,6 +278,9 @@ enum arm_smmu_s2cr_privcfg {
>  
>  #define FSYNR0_WNR			(1 << 4)
>  
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
>  static int force_stage;
>  module_param(force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
> @@ -1533,6 +1536,68 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
>  }
>  
> +static int add_pci_window_reserved_regions(struct iommu_domain *domain,
> +					   struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct iommu_reserved_region *region;
> +	struct resource_entry *window;
> +	phys_addr_t start;
> +	size_t length;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		if (resource_type(window->res) != IORESOURCE_MEM &&
> +		    resource_type(window->res) != IORESOURCE_IO)
> +			continue;
> +
> +		start = window->res->start - window->offset;
> +		length = window->res->end - window->res->start + 1;
> +
> +		iommu_reserved_region_for_each(region, domain) {
> +			if (region->start == start && region->length == length)
> +				continue;
> +		}
> +		region = kzalloc(sizeof(*region), GFP_KERNEL);
> +		if (!region)
> +			return -ENOMEM;
> +
> +		region->start = start;
> +		region->length = length;
> +
> +		list_add_tail(&region->list, &domain->reserved_regions);
> +	}
> +	return 0;
> +}

Per the previous observation, let's just convert
iova_reserve_pci_windows() into a public iommu_dma_get_dm_regions()
callback...

> +static int arm_smmu_add_reserved_regions(struct iommu_domain *domain,
> +					 struct device *device)
> +{
> +	struct iommu_reserved_region *region;
> +	int ret = 0;
> +
> +	/* An arbitrary 1MB region starting at 0x8000000 is reserved for MSIs */
> +	if (!domain->iova_cookie) {
> +
> +		region = kzalloc(sizeof(*region), GFP_KERNEL);
> +		if (!region)
> +			return -ENOMEM;
> +
> +		region->start = MSI_IOVA_BASE;
> +		region->length = MSI_IOVA_LENGTH;
> +		list_add_tail(&region->list, &domain->reserved_regions);
> +
> +		ret = iommu_get_dma_msi_region_cookie(domain,
> +						region->start, region->length);
> +		if (ret)
> +			return ret;

...and stick this bit in there as well. Then we only need to add code to
individual IOMMU drivers if there are also regions which bypass
translation at the IOMMU itself (if someone does ever integrate an SMMU
with an upstream/parallel ITS, x86-style, I think we'd need to describe
that with a DT property on the SMMU, so it would have to be the SMMU
driver's responsibility).

Robin.

> +	}
> +
> +	if (dev_is_pci(device))
> +		ret =  add_pci_window_reserved_regions(domain,
> +						       to_pci_dev(device));
> +	return ret;
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -1548,6 +1613,7 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>  	.of_xlate		= arm_smmu_of_xlate,
> +	.add_reserved_regions	= arm_smmu_add_reserved_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> 
