From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only (v3)
Date: Mon, 29 May 2017 16:38:31 +0200
Message-ID: <20170529143831.GA30388@8bytes.org>
References: <20170407102039.GW7266@8bytes.org>
 <1495439281-24005-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495439281-24005-1-git-send-email-arindam.nath@amd.com>
Sender: stable-owner@vger.kernel.org
To: arindam.nath@amd.com, Tom Lendacky <thomas.lendacky@amd.com>
Cc: iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, John.Bridgman@amd.com, drake@endlessm.com, Suravee.Suthikulpanit@amd.com, linux@endlessm.com, Craig Stein <stein12c@gmail.com>, michel@daenzer.net, Felix.Kuehling@amd.com, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Arindam,

I met Tom Lendacky last week in Nuremberg last week and he told me he is
working on the same area of the code that this patch is for. His reason
for touching this code was to solve some locking problems. Maybe you two
can work together on a joint approach to improve this?

On Mon, May 22, 2017 at 01:18:01PM +0530, arindam.nath@amd.com wrote:
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 63cacf5..1edeebec 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2227,15 +2227,26 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
>  
>  static void __queue_flush(struct flush_queue *queue)
>  {
> -	struct protection_domain *domain;
> -	unsigned long flags;
>  	int idx;
>  
> -	/* First flush TLB of all known domains */
> -	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
> -		domain_flush_tlb(domain);
> -	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> +	/* First flush TLB of all domains which were added to flush queue */
> +	for (idx = 0; idx < queue->next; ++idx) {
> +		struct flush_queue_entry *entry;
> +
> +		entry = queue->entries + idx;
> +
> +		/*
> +		 * There might be cases where multiple IOVA entries for the
> +		 * same domain are queued in the flush queue. To avoid
> +		 * flushing the same domain again, we check whether the
> +		 * flag is set or not. This improves the efficiency of
> +		 * flush operation.
> +		 */
> +		if (!entry->dma_dom->domain.already_flushed) {
> +			entry->dma_dom->domain.already_flushed = true;
> +			domain_flush_tlb(&entry->dma_dom->domain);
> +		}
> +	}

There is also a race condition here I have to look into. It is not
introduced by your patch, but needs fixing anyway. I'll look into this
too.


Regards,

	Joerg
