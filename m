From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add resv_regions ops
Date: Thu, 17 Jan 2019 17:06:04 +0000
Message-ID: <749b1bfa-b2b4-336f-fbc4-2a2bed72ee35@arm.com>
References: <1547671814-30088-1-git-send-email-navneetk@nvidia.com>
	<1547671814-30088-5-git-send-email-navneetk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1547671814-30088-5-git-send-email-navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 16/01/2019 20:50, Navneet Kumar wrote:
> Add support for get/put reserved regions.

For any particular reason? If you're aiming to get 
VFIO-passthrough-with-MSIs working on Tegra, this probably won't be 
correct anyway...

> Signed-off-by: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/tegra-smmu.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 4b43c63..e848a45 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -22,6 +22,9 @@
>   #include <soc/tegra/ahb.h>
>   #include <soc/tegra/mc.h>
>   
> +#define MSI_IOVA_BASE	0x8000000

...because this arbitrary IOVA relies on writes to the MSI doorbell 
undergoing address translation at the IOMMU just like any other access. 
Looking at Tegra 134, that seems to implement an MSI doorbell internal 
to the PCIe root complex, far upstream of translation, therefore at the 
very least you'd need to reserve whatever IOVA region is shadowed by 
that doorbell in PCI memory space...

> +#define MSI_IOVA_LENGTH	0x100000
> +
>   struct tegra_smmu_group {
>   	struct list_head list;
>   	const struct tegra_smmu_group_soc *soc;
> @@ -882,6 +885,31 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   	return iommu_fwspec_add_ids(dev, &id, 1);
>   }
>   
> +static void tegra_smmu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +					prot, IOMMU_RESV_SW_MSI);

...and as an untranslatable hardware MSI region, not a software-managed one.

Robin.

> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +
> +	iommu_dma_get_resv_regions(dev, head);
> +}
> +
> +static void tegra_smmu_put_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +
>   static const struct iommu_ops tegra_smmu_ops = {
>   	.capable = tegra_smmu_capable,
>   	.domain_alloc = tegra_smmu_domain_alloc,
> @@ -896,6 +924,9 @@ static const struct iommu_ops tegra_smmu_ops = {
>   	.iova_to_phys = tegra_smmu_iova_to_phys,
>   	.of_xlate = tegra_smmu_of_xlate,
>   	.pgsize_bitmap = SZ_4K,
> +
> +	.get_resv_regions = tegra_smmu_get_resv_regions,
> +	.put_resv_regions = tegra_smmu_put_resv_regions,
>   };
>   
>   static void tegra_smmu_ahb_enable(void)
> 
