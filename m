From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v4] iommu/amd: Add support for fast IOTLB flushing
Date: Mon, 5 Mar 2018 08:08:21 +0700
Message-ID: <f9396eef-26b9-5280-1250-4aaeb0a38c32@amd.com>
References: <1519197585-10546-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1519197585-10546-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ping..

Joerg, when you get a chance, would you please let me know if you have any other concerns for this v4.

Thanks,
Suravee

On 2/21/18 2:19 PM, Suravee Suthikulpanit wrote:
> Since AMD IOMMU driver currently flushes all TLB entries
> when page size is more than one, use the same interface
> for both iommu_ops.flush_iotlb_all() and iommu_ops.iotlb_sync().
> 
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
> Changes from v3 (https://patchwork.kernel.org/patch/10193235)
>   * Change amd_iommu_iotlb_range_add() to no-op and iotlb_sync()
>     to full domain flush for now since we currently flush all entries
>     when the page size is more than one.
>   * Fine-grained invalidation will be introduced in subsequent
>     patch series.
> 
>   drivers/iommu/amd_iommu.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index fed8059..6061a8d 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3043,9 +3043,6 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
>   	unmap_size = iommu_unmap_page(domain, iova, page_size);
>   	mutex_unlock(&domain->api_lock);
>   
> -	domain_flush_tlb_pde(domain);
> -	domain_flush_complete(domain);
> -
>   	return unmap_size;
>   }
>   
> @@ -3163,6 +3160,19 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return dev_data->defer_attach;
>   }
>   
> +static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct protection_domain *dom = to_pdomain(domain);
> +
> +	domain_flush_tlb_pde(dom);
> +	domain_flush_complete(dom);
> +}
> +
> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +}
> +
>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> @@ -3181,6 +3191,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	.apply_resv_region = amd_iommu_apply_resv_region,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
> +	.iotlb_range_add = amd_iommu_iotlb_range_add,
> +	.iotlb_sync = amd_iommu_flush_iotlb_all,
>   };
>   
>   /*****************************************************************************
> 
