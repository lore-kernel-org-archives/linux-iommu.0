From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
	callback
Date: Thu, 10 Nov 2016 16:46:06 +0100
Message-ID: <20161110154606.GH2078@8bytes.org>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-9-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478258646-3117-9-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 04, 2016 at 11:24:06AM +0000, Eric Auger wrote:
> The function populates the list of reserved regions with the
> PCI host bridge windows and the MSI IOVA range.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Why do you care about IO resources?

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
> +
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

Gah, I hate this. Is there no other and simpler way to get the MSI
region than allocating an iova-domain? In that regard, I also _hate_ the
patch before introducing this weird iommu_get_dma_msi_region_cookie()
function.

Allocation an iova-domain is pretty expensive, as it also includes
per-cpu data-structures and all, so please don't do this just for the
purpose of compiling a list of reserved regions.



	Joerg
