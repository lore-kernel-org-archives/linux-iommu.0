From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/dma: fix trival coding style mistake
Date: Wed, 23 May 2018 13:51:56 +0100
Message-ID: <b4086d30-035e-ae47-0c2f-b537c5481e9e@arm.com>
References: <1527055369-13192-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1527055369-13192-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/05/18 07:02, Zhen Lei wrote:
> No functional changes.

What's the mistake?

> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ddcbbdb..4e885f7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	LIST_HEAD(resv_regions);
>   	int ret = 0;
> 
> +	if (!dev)
> +		return 0;

Logically, it makes no sense at all to call this function without a 
valid device; doing the check in init_domain was a deliberate decision 
to reflect that. This isn't a cleanup path shared by multiple callers 
where the "accept NULL for simplicity" argument might apply.

> +
>   	if (dev_is_pci(dev))
>   		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> 
> @@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   		hi = iova_pfn(iovad, region->start + region->length - 1);
>   		reserve_iova(iovad, lo, hi);
> 
> -		if (region->type == IOMMU_RESV_MSI)
> +		if (region->type == IOMMU_RESV_MSI) {
>   			ret = cookie_init_hw_msi_region(cookie, region->start,
>   					region->start + region->length);
> -		if (ret)
> -			break;
> +			if (ret)
> +				break;
> +		}

Why? ret is already initialised appropriately, and the coding style even 
says that going beyond 3 levels of indentation is undesirable...

Robin.

>   	}
>   	iommu_put_resv_regions(dev, &resv_regions);
> 
> @@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
> 
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> -	if (!dev)
> -		return 0;
> 
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
> --
> 1.8.3
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
