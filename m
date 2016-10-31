From: Xunlei Pang <xpang@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix the size calculation of pasid table
Date: Mon, 31 Oct 2016 19:30:32 +0800
Message-ID: <58172B58.804@redhat.com>
References: <1473648551-10025-1-git-send-email-xlpang@redhat.com>
 <20160919121827.GB3541@8bytes.org> <1476274674.16627.173.camel@infradead.org>
 <1477829902.4154.9.camel@infradead.org>
Reply-To: xlpang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477829902.4154.9.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Xunlei Pang <xlpang@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 2016/10/30 at 20:18, David Woodhouse wrote:
> On Wed, 2016-10-12 at 13:17 +0100, David Woodhouse wrote:
>> Yes, that looks correct. I think we may also need to limit it, because
>> full 20-bit PASID support means we'll attempt an order 11 allocation.
>> But that's certainly correct for now
> Actually, not quite correct. You fixed the allocation but not the free.
> And Mika had reported that even the *correct* allocation was failing
> because it was too large. So I've done it differently (untested)...

Yes, your fix looks correct.

Thanks,
Xunlei

> -----
> Subject: [PATCH] iommu/vt-d: Fix PASID table allocation
>
> Somehow I ended up with an off-by-three error in calculating the size of
> the PASID and PASID State tables, which triggers allocations failures as
> those tables unfortunately have to be physically contiguous.
>
> In fact, even the *correct* maximum size of 8MiB is problematic and is
> wont to lead to allocation failures. Since I have extracted a promise
> that this *will* be fixed in hardware, I'm happy to limit it on the
> current hardware to a maximum of 0x20000 PASIDs, which gives us 1MiB
> tables — still not ideal, but better than before.
>
> Reported by Mika Kuoppala <mika.kuoppala@linux.intel.com> and also by
> Xunlei Pang <xlpang@redhat.com> who submitted a simpler patch to fix
> only the allocation (and not the free) to the "correct" limit... which
> was still problematic.
>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> ---
>  drivers/iommu/intel-svm.c   | 28 +++++++++++++++++-----------
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8ebb353..cb72e00 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -39,10 +39,18 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  	struct page *pages;
>  	int order;
>  
> -	order = ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
> -	if (order < 0)
> -		order = 0;
> -
> +	/* Start at 2 because it's defined as 1^(1+PSS) */
> +	iommu->pasid_max = 2 << ecap_pss(iommu->ecap);
> +
> +	/* Eventually I'm promised we will get a multi-level PASID table
> +	 * and it won't have to be physically contiguous. Until then,
> +	 * limit the size because 8MiB contiguous allocations can be hard
> +	 * to come by. The limit of 0x20000, which is 1MiB for each of
> +	 * the PASID and PASID-state tables, is somewhat arbitrary. */
> +	if (iommu->pasid_max > 0x20000)
> +		iommu->pasid_max = 0x20000;
> +
> +	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>  	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!pages) {
>  		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
> @@ -53,6 +61,8 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
>  
>  	if (ecap_dis(iommu->ecap)) {
> +		/* Just making it explicit... */
> +		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
>  		pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  		if (pages)
>  			iommu->pasid_state_table = page_address(pages);
> @@ -68,11 +78,7 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  
>  int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
>  {
> -	int order;
> -
> -	order = ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
> -	if (order < 0)
> -		order = 0;
> +	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>  
>  	if (iommu->pasid_table) {
>  		free_pages((unsigned long)iommu->pasid_table, order);
> @@ -371,8 +377,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		}
>  		svm->iommu = iommu;
>  
> -		if (pasid_max > 2 << ecap_pss(iommu->ecap))
> -			pasid_max = 2 << ecap_pss(iommu->ecap);
> +		if (pasid_max > iommu->pasid_max)
> +			pasid_max = iommu->pasid_max;
>  
>  		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
>  		ret = idr_alloc(&iommu->pasid_idr, svm,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2d9b6500..d49e26c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -429,6 +429,7 @@ struct intel_iommu {
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
>  	struct idr pasid_idr;
> +	u32 pasid_max;
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
>  	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
> -- 
> 2.5.5
>
